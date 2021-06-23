Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19413B227E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 23:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWVfI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 17:35:08 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46721 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWVfI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Jun 2021 17:35:08 -0400
Received: by mail-wr1-f44.google.com with SMTP id a11so4179004wrt.13
        for <linux-rdma@vger.kernel.org>; Wed, 23 Jun 2021 14:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQNp5IMse43OkEqE+mzPjQAcJhkyYGIkXC2qTp6ZlDQ=;
        b=EOj6WxHMsswu1rSlC9IiXOWATsjUl3ZxzWc8i5+hAhE66ixY4cQ3XaZ8w6jhm9gozD
         aMGMbDLB64m97OxtWjAl2nTY4FqNbGMFOM7Nq5HTmEapyrinBw1OOaPc+pzlOLpFYPZR
         SRfQCcwpEEMOtMBZKobQ+qRTjNip623qcYEJE7ehzy4tTqBIn+CTGiVyf9wjg2CFTlZN
         YzdGSYqCdfhzcCOAqcC0qG5BWbMHeHzyn9RvwLi5ZC2OUwbxHLZPToAEfnbpwvp0VESn
         IciXEe6OrKQmPFN6kjoaak2ANIWjPlB3QDXJAO/c3UH7760cZXUb/jm8uLSA3VfN1Grm
         O9Dw==
X-Gm-Message-State: AOAM532jqUwOL2YMbccD9TZvxhTpC852F46rqqnVbPT9jCIV17pXyI6E
        VcvkzSIyVx+yBnWzzNiD0tplxbS58q0=
X-Google-Smtp-Source: ABdhPJzUwExWUOCqamnHQeG8Fi6g/8jDwAybW/Aw+aHAFxxd/7IPZIo1VGhAd0ZVkKe5EMzhf3h4bA==
X-Received: by 2002:a5d:59a5:: with SMTP id p5mr188596wrr.27.1624483969473;
        Wed, 23 Jun 2021 14:32:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d7a5:9de1:faa6:69b7? ([2601:647:4802:9070:d7a5:9de1:faa6:69b7])
        by smtp.gmail.com with ESMTPSA id u10sm1024437wmm.21.2021.06.23.14.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 14:32:48 -0700 (PDT)
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
Date:   Wed, 23 Jun 2021 14:32:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hello
> 
> Gentle ping here, this issue still exists on latest 5.13-rc7
> 
> # time nvme reset /dev/nvme0
> 
> real 0m12.636s
> user 0m0.002s
> sys 0m0.005s
> # time nvme reset /dev/nvme0
> 
> real 0m12.641s
> user 0m0.000s
> sys 0m0.007s

Strange that even normal resets take so long...
What device are you using?

> # time nvme reset /dev/nvme0
> 
> real 1m16.133s
> user 0m0.000s
> sys 0m0.007s

There seems to be a spurious command timeout here, but maybe this
is due to the fact that the queues take so long to connect and
the target expires the keep-alive timer.

Does this patch help?
--
diff --git a/drivers/nvme/target/fabrics-cmd.c 
b/drivers/nvme/target/fabrics-cmd.c
index 7d0f3523fdab..f4a7db1ab3e5 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -142,6 +142,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl 
*ctrl, struct nvmet_req *req)
                 }
         }

+       /*
+        * Controller establishment flow may take some time, and the 
host may not
+        * send us keep-alive during this period, hence reset the
+        * traffic based keep-alive timer so we don't trigger a
+        * controller teardown as a result of a keep-alive expiration.
+        */
+       ctrl->reset_tbkas = true;
+
         return 0;

  err:
--

>> target:
>> [  934.306016] nvmet: creating controller 1 for subsystem testnqn for
>> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
>> [  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
>> [  944.900051] nvmet: ctrl 1 fatal error occurred!
>> [ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
>> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
>>
>> client:
>> [  857.264029] nvme nvme0: resetting controller
>> [  864.115369] nvme nvme0: creating 40 I/O queues.
>> [  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>> [  868.001673] nvme nvme0: resetting controller
>> [  935.396789] nvme nvme0: I/O 9 QID 0 timeout
>> [  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
>> [  935.438080] nvme nvme0: creating 40 I/O queues.
>> [  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.
