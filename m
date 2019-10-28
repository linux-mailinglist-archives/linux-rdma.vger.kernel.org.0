Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB21FE726F
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfJ1NNW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:13:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33525 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfJ1NNW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 09:13:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id y39so9096610qty.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hHAmyNyt0/UPcUBOa5Y8r6bMgHDJnqFgQ/fdHQ275L0=;
        b=NoDafDCSiXnaHG/BEIoccNoX2VosfOLzXMXdZQ46Xa/SFCOxY3RLbmdnhZgcq8hGeu
         8VplOQjpu/lGuZnLr3EsyT2xxLotCvKlYSdRsDnKJtzBbHXgeAiViegJP4Trp8mcjSeo
         9cKcSZLMCuEnlsv42f7a2sWzbiT0is+FLvpIQ9iy8pootGuDrgwDVdBONXHAh6eoDSQ1
         ATII+e5W4YB/hUdWYYOtQZMKFVHw77KWuawQSunU+iznIJ/QTtoKMS0wi/Uz1T906CCW
         jTiJFvAY4IoM3YH/nqOeFFESHkZHS52TX+PXLOIN2zH1rmfeNUQf9/IAP6JfSKVL+yK6
         fsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hHAmyNyt0/UPcUBOa5Y8r6bMgHDJnqFgQ/fdHQ275L0=;
        b=quOELaeHossUnS3C0W0Bk9yiB4DyigFgH7bh/H/r4TVN2DNp/gWR6TwY7Trr+1ODL+
         yBXZ0X22CFPKrSWcxNtbVuH01oCL6fNfCYvsJutkN/m3kCk85lB5qHY89/I6yLKSfHuN
         wB06Xv2Xcoe1Cf1Ss0QauqDuRrHZFHYlbzacKlNMJ8Kpm7p99hQTcjwewcORoNDff0US
         bYT3YEYQLXMzClRgOuHE2JT0DV3bAY4e8maX0qMfPhdoGpa8b9k6rQX3QKHgb6iISTR6
         MXCmc5mgyvidJNZC1Y4TurGkxCOY5UHTIX8t7BJw7wXB1OtwENCIuqPvmoR7gEEGy9iJ
         uk3Q==
X-Gm-Message-State: APjAAAU8ezfCEOPtf0FI+gZWCS5XUjUj2pgTEfx3PgIYvq0l/1jlI/GJ
        DKlP1tDsDee/zEnUlHES2/TxoQ==
X-Google-Smtp-Source: APXvYqy0kd1ZMLmvNoESY9DcL+8wdbB/MsNBJE59OkLlUGWlMgT951kC/cbf0/8pt/vvDMlYa7FI9A==
X-Received: by 2002:ac8:4456:: with SMTP id m22mr16343560qtn.336.1572268400944;
        Mon, 28 Oct 2019 06:13:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id y29sm7048613qtc.8.2019.10.28.06.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 06:13:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP4pj-0003zL-L2; Mon, 28 Oct 2019 10:13:19 -0300
Date:   Mon, 28 Oct 2019 10:13:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH rdma-next 6/6] RDMA/srpt: Use private_data_len instead of
 hardcoded value
Message-ID: <20191028131319.GA15102@ziepe.ca>
References: <20191020071559.9743-1-leon@kernel.org>
 <20191020071559.9743-7-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020071559.9743-7-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 10:15:59AM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index daf811abf40a..e66366de11e9 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2609,7 +2609,7 @@ static int srpt_cm_handler(struct ib_cm_id *cm_id,
>  	case IB_CM_REJ_RECEIVED:
>  		srpt_cm_rej_recv(ch, event->param.rej_rcvd.reason,
>  				 event->private_data,
> -				 IB_CM_REJ_PRIVATE_DATA_SIZE);
> +				 event->private_data_len);

So, I took a look and found a heck of a lot more places assuming the
size of private data that really should be checked if we are going to
introduce a buffer length here.

This is the first couple I noticed, but there were many many more and
they all should be handled..

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2677,9 +2677,14 @@ static void srp_ib_cm_rej_handler(struct ib_cm_id *cm_id,
                break;
 
        case IB_CM_REJ_CONSUMER_DEFINED:
+               if (event->private_data_len < sizeof(struct srp_login_rej)) {
+                       ch->status = -ECONNRESET;
+                       break;
+               }
+

--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -985,12 +985,15 @@ static int ipoib_cm_rep_handler(struct ib_cm_id *cm_id,
 {
        struct ipoib_cm_tx *p = cm_id->context;
        struct ipoib_dev_priv *priv = ipoib_priv(p->dev);
        struct ipoib_cm_data *data = event->private_data;
        struct sk_buff_head skqueue;
        struct ib_qp_attr qp_attr;
        int qp_attr_mask, ret;
        struct sk_buff *skb;
 
+       if (event->private_data_len < sizeof(*data))
+               return -EINVAL;
+


Thanks,
Jason
