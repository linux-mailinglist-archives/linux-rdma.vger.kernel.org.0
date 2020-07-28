Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25712313C2
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgG1UUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 16:20:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38403 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgG1UUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 16:20:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id m16so10578857pls.5
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 13:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gef16de5EpPX1YeoY9rwySs9VcunkRYa4UoYB5zUiY0=;
        b=NxY5xF4rZadhzkHYh1g7/1EFA/5SaxAuIH3Xc55CESClNd6Qh7JoUC4W+OhFQikEAJ
         OGIWZxoATWzlc9QVD3P3/6828QeXhkqrU5rTUDqFkkyn8uKdv2dd9xiJAbK8IPH1AHO6
         /r8r0qzTyGr9OwXcMP7LOnNpbvg9Tb5rnW6NIyuvIZ1xJoGgFYjDv5C6sDVmavNtpprM
         baLlpkzf2voYbP2X02muoxcqIxqGV9bjp1yxKdlw6WhxnKhnJofzy2hRqaP8jBkzdAB5
         V511PqQ+nNDnDWNdbUlWdo2WCvxfq5zciglCuUMAcUtRSElHDHg2BzLDlgnRODhiDXaA
         CXrg==
X-Gm-Message-State: AOAM531MHWSe4xNplC6p9bakDRLQb61qKhPM5YhuL70yvFRbi7imx0eQ
        4AvgGAnOSXtgKp7nh+j1aoA=
X-Google-Smtp-Source: ABdhPJyAwJgram0zIs0QZFhwwRwEYyn8Z2/U0hhhcXwICWWPKWOHQ5fbr03Bhd/NjD5JmFFBVlUx2w==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr5957620pjb.111.1595967641522;
        Tue, 28 Jul 2020 13:20:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe? ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
        by smtp.gmail.com with ESMTPSA id s18sm9585186pfd.132.2020.07.28.13.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 13:20:40 -0700 (PDT)
Subject: Re: Hang at NVME Host caused by Controller reset
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        bharat@chelsio.com
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
 <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
 <20200728174224.GA5497@chelsio.com>
 <3963dc58-1d64-b6e1-ea27-06f3030d5c6e@grimberg.me>
Message-ID: <54cc5ecf-bd04-538c-fa97-7c4d2afd92d7@grimberg.me>
Date:   Tue, 28 Jul 2020 13:20:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3963dc58-1d64-b6e1-ea27-06f3030d5c6e@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> This time, with "nvme-fabrics: allow to queue requests for live queues"
>> patch applied, I see hang only at blk_queue_enter():
> 
> Interesting, does the reset loop hang? or is it able to make forward
> progress?

Looks like the freeze depth is messed up with the timeout handler.
We shouldn't call nvme_tcp_teardown_io_queues in the timeout handler
because it messes with the freeze depth, causing the unfreeze to not
wake the waiter (blk_queue_enter). We should simply stop the queue
and complete the I/O, and the condition was wrong too, because we
need to do it only for the connect command (which cannot reset the
timer). So we should check for reserved in the timeout handler.

Can you please try this patch?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62fbaecdc960..c3288dd2c92f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -464,6 +464,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl 
*ctrl)
         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
                 return;

+       dev_warn(ctrl->device, "starting error recovery\n");
         queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
  }

@@ -2156,33 +2157,37 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
         struct nvme_tcp_ctrl *ctrl = req->queue->ctrl;
         struct nvme_tcp_cmd_pdu *pdu = req->pdu;

-       /*
-        * Restart the timer if a controller reset is already scheduled. Any
-        * timed out commands would be handled before entering the 
connecting
-        * state.
-        */
-       if (ctrl->ctrl.state == NVME_CTRL_RESETTING)
-               return BLK_EH_RESET_TIMER;
-
         dev_warn(ctrl->ctrl.device,
                 "queue %d: timeout request %#x type %d\n",
                 nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);

-       if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
+       switch (ctrl->ctrl.state) {
+       case NVME_CTRL_RESETTING:
                 /*
-                * Teardown immediately if controller times out while 
starting
-                * or we are already started error recovery. all outstanding
-                * requests are completed on shutdown, so we return 
BLK_EH_DONE.
+                * Restart the timer if a controller reset is already 
scheduled.
+                * Any timed out commands would be handled before 
entering the
+                * connecting state.
                  */
-               flush_work(&ctrl->err_work);
-               nvme_tcp_teardown_io_queues(&ctrl->ctrl, false);
-               nvme_tcp_teardown_admin_queue(&ctrl->ctrl, false);
-               return BLK_EH_DONE;
+               return BLK_EH_RESET_TIMER;
+       case NVME_CTRL_CONNECTING:
+               if (reserved) {
+                       /*
+                        * stop queue immediately if controller times 
out while connecting
+                        * or we are already started error recovery. all 
outstanding
+                        * requests are completed on shutdown, so we 
return BLK_EH_DONE.
+                        */
+                       nvme_tcp_stop_queue(&ctrl->ctrl, 
nvme_tcp_queue_id(req->queue));
+                       nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
+                       nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+                       blk_mq_complete_request(rq);
+                       return BLK_EH_DONE;
+               }
+               /* fallthru */
+       default:
+       case NVME_CTRL_LIVE:
+               nvme_tcp_error_recovery(&ctrl->ctrl);
         }

-       dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-       nvme_tcp_error_recovery(&ctrl->ctrl);
-
         return BLK_EH_RESET_TIMER;
  }
--
