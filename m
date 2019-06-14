Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDCE45E7B
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfFNNjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 09:39:45 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfFNNjp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jun 2019 09:39:45 -0400
Received: from [192.168.1.110] ([77.4.92.40]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPGJf-1i0txJ0cqj-00PaAc; Fri, 14 Jun 2019 15:39:16 +0200
Subject: Re: [PATCH] RDMA/ucma: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190604154222.GA8938@embeddedor>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <f8d5dcb8-b665-b34e-3869-a720fd6f6899@metux.net>
Date:   Fri, 14 Jun 2019 15:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190604154222.GA8938@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TyNnlCCne/1Ppqq1bYzrL6JZCGHTih8twwaASqDhXeiIa4I/XSy
 E4A5ttx7aDQau/tjbadApxfoHDkB2T5svbpfYmr2W8BDkQmSjf7XrAGtU0wUdN6Xf0fIStk
 U1SZ4C1VYX6rqqrwrAhfKxnXOV0Vat/fWVGmPYYWYML9wvys0/hMQIEDEAohZDrX+eM1WUq
 SgdCBw244hyQ6AhSu0XFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UjmK0ABtvNc=:XVKD2tvTEcA8JMRMpy0Htt
 FURTKxjfIGc/KkFmVsLJL0pScwNlBoH84DzLmULSbZNiLfW1j1/U75nqxHMCw69r0koF1x3NS
 1eOgDwYx3Idh3WZ2EQ1Wd1tbRW9LnBjC5loBJUOODwdcM7zjrsUezonaxWaD0vNqABE3CcgvB
 J0wsyqs1s3bmCmDroBEY0xKHLzcX3vIWczdBBSehV3oAd405VzXE0gLx7J75vjVSPfDrVu3TK
 l/ffJmemx9p/ynRX8CGMKVp0s4UmVHoo1gqtD2z6WuqxNP+yzGb+rfHEkAdKpQuDhNOmJ2YR1
 n/kX+yH/FcuffTYoFAfOM1oY2enBt+x3eXGrFu3uVI16Hb4fYVfuScp+znSCkaBB+6FdQ/tgh
 eiIUKrd//XE5EjjGNEvkziApCl31uZzfQvd+ejQhi4Pv3bLPetHK0F5+zxTDWyuWPFJJK5Fvk
 r6fw/pbY1edstTcVAE28wqQf2FfhPBpNHnybutpCq+HT+gdNt6OXBw6Gg05EOjLOdB9jGbDRt
 FAkdvtxDU5p2XQmP5bLi8Q+1QqcvYnfGQZsRGM1xowbyneNrUcEQ0MEaolXO3lW/4gwUlpZlZ
 mCJCuLIWh2NCvvxfMnwBjIKnj5HTFsQ/3YZuPJvmkA4Iqs8Yih2UuV/DQDCnRWorQPBfA/qXK
 +Kfl/PJDPO4+ipXO0xLOwaxBGKarddEpf2hX+t4IERfWhMZWoNETaeGuKHLT4srg++GNHhSpV
 W7x+rhROLzGd68qKQcywrBgTBr0Q+EYZt7HtwXa4OG7RTXM0evzPtFpIt/Q=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04.06.19 17:42, Gustavo A. R. Silva wrote:

Hi,

<snip>

> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 140a338a135f..cbe460076611 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -951,8 +951,7 @@ static ssize_t ucma_query_path(struct ucma_context *ctx,
>  		}
>  	}
>  
> -	if (copy_to_user(response, resp,
> -			 sizeof(*resp) + (i * sizeof(struct ib_path_rec_data))))
> +	if (copy_to_user(response, resp, struct_size(resp, path_data, i)))
>  		ret = -EFAULT;

have you already considered further reducing the boilerplate by putting
this into it's own helper macro, so it finally would look like this ?

+	if (copy_to_user_structs(response, resp, resp, path_data, i)))
>  		ret = -EFAULT;

You've posted similar patches that also affected things like kzalloc().
Maybe for those it would be better candidates for putting everything
into its own helper macro ? (I've already got that on my 2do list, but
not sure whether maintainers really like to be bothered with those
kind of patches ;-)).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
