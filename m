Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB6917EE42
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 02:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCJByq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 21:54:46 -0400
Received: from m12-13.163.com ([220.181.12.13]:59600 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgCJByq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Mar 2020 21:54:46 -0400
X-Greylist: delayed 931 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 21:54:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=/d4sH
        TItJWIpgLzu6W3pE25AYoZLiG9IqUgG1rZkd80=; b=nGkruSpoUEJN9LuLwPXYm
        o6yQdaPgHN1D5uCuV+hVLUEPAjMZxoJ1JkQRZ/IhblBGx6xmxeU0tCOWdfEpTkAZ
        3r3DFjJXLcLryICTDzSMAJf0P+LHevUbAMXQkiPNMpyw8SIusUVnx+WPgc4Y5A7g
        aGQxqDl4fNVMeooRnnjE4Y=
Received: from [192.168.1.199] (unknown [139.159.243.11])
        by smtp9 (Coremail) with SMTP id DcCowACHjrqx72ZeGwuWAw--.5059S2;
        Tue, 10 Mar 2020 09:38:58 +0800 (CST)
Subject: Re: Fwd: [PATCH] MAINTAINERS: Update maintainers for HISILICON ROCE
 DRIVER
To:     liweihang <liweihang@huawei.com>, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <1583575114-32194-1-git-send-email-liweihang@huawei.com>
 <B82435381E3B2943AA4D2826ADEF0B3A022789FE@DGGEML522-MBX.china.huawei.com>
Cc:     linux-rdma@vger.kernel.org, huwei87@hisilicon.com
From:   "Wei Hu (Xavier)" <xavier_huwei@163.com>
Message-ID: <b4fdb472-eee2-21fc-b753-6648533f105f@163.com>
Date:   Tue, 10 Mar 2020 09:38:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A022789FE@DGGEML522-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DcCowACHjrqx72ZeGwuWAw--.5059S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UKryDWF43CF43Gw4DArb_yoW8JFy7pa
        1rGr4xCr97Wr12kwnFga42vF97Xa18GryakrZFy3WrZF9IyF1j9r1UKw12qaykXry8KF4f
        JrsFgr1I93yUAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_8n5UUUUU=
X-Originating-IP: [139.159.243.11]
X-CM-SenderInfo: 50dyxv5ubk34lhl6il2tof0z/xtbBzxLio1aD6fl-NQAAsT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/3/10 9:33, liweihang wrote:
> 
> 
> 
> -------- Forwarded Message --------
> Subject: [PATCH] MAINTAINERS: Update maintainers for HISILICON ROCE DRIVER
> Date: Sat, 7 Mar 2020 18:02:31 +0800
> From: Weihang Li <liweihang@huawei.com>
> To: dledford@redhat.com <dledford@redhat.com>, jgg@ziepe.ca <jgg@ziepe.ca>
> CC: linux-rdma@vger.kernel.org <linux-rdma@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
> 
> Add myself as a maintainer for HNS RoCE drivers, and update Xavier's e-amil
> address.
> 
> Cc: Lijun Ou <oulijun@huawei.com>
> Cc: Wei Hu(Xavier) <huwei87@hisilicon.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6158a14..e8ae08e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7575,7 +7575,8 @@ F:	Documentation/admin-guide/perf/hisi-pmu.rst
>    HISILICON ROCE DRIVER
>   M:	Lijun Ou <oulijun@huawei.com>
> -M:	Wei Hu(Xavier) <xavier.huwei@huawei.com>
> +M:	Wei Hu(Xavier) <huwei87@hisilicon.com>
> +M:	Weihang Li <liweihang@huawei.com>
>   L:	linux-rdma@vger.kernel.org
>   S:	Maintained
>   F:	drivers/infiniband/hw/hns/
> 
Acked-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>

