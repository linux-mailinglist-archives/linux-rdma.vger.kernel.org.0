Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73AA1076FF
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 19:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKVSJl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 13:09:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36992 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKVSJk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Nov 2019 13:09:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id e187so7094972qkf.4
        for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2019 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j6hjAPACW2t23GGWuGhEiG9CB9fLgkLWsIbwSK8J4eo=;
        b=RxILqWOnTvyyt4GYrQUd0A3BpxbyMqN9PJBUKKy15MnwSMGcRspALGAYq6acexuaX1
         tjjZoqpX+XfHKuRNeXzT9FW22eIpfiSR6RyzB2tq7cbDQ7NX1fB8f/RqRKqBkulyr8MI
         FjaURZU0yQy5YuhopwxapXjMLxu9u9QOwcJU6guwnTzkfiei/Hn3PIVFdM1Hf41AuHND
         Lj4+4okX2yw3pSFJG4rGq/2mGPJmRGM+aUpRRzn6HDMKmGvftEwjOuSNxlt/h1usYpbf
         OmqO3/++kJ9O4b4WGvPR5S9VkxkVX/cw3sCIoYETFcUJizJ+nxQoAS5Hw4hAg1hR6WOu
         PfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j6hjAPACW2t23GGWuGhEiG9CB9fLgkLWsIbwSK8J4eo=;
        b=qF2/Q81Ae/Pqu6DulyKtdras0vzLOB8HxGrLbSSTVBXdpRzOYvMWnB5BmlBXBGi0KI
         lpb1myqUIE2r06nDVm0PbP2r9RnfPJIeyGSBQT1aON6yuRMZ0UEyB8UTH8wgALO8HmaD
         fYsqqi3cIa+HHPb9QJSgys9TQFGntFPPDMagAi1zTjtHv+53O1By4lat8z1wV1jjJ87c
         /aPlMSl7s6xDWNJaNqPCuswAnI0Nq+N4Has7aR//SV+6KWzel776W3gjdq1ni7Sv4sCD
         a8dnq0Pfx8tjy0LD6xZ1i7BgtxdlDX7xJq8pmdZEv6C6a9MEEkJfsRT3iBRHfFasvIQE
         CKPA==
X-Gm-Message-State: APjAAAWN+jupOgIf1Q6xBNaLFDSzSkxkF+4+ym2mn+OCNaDOEvHkj9B7
        SWKUscc8yAh539s600z0nyryqw==
X-Google-Smtp-Source: APXvYqy+DyuaLfdkl7fDkFO9/WX1JMi4lznHMSLs2eZNNuDBeWcM+CFABW0C7lag4uSjT+q1cGW0Rw==
X-Received: by 2002:ae9:efc5:: with SMTP id d188mr9025547qkg.178.1574446175331;
        Fri, 22 Nov 2019 10:09:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id d134sm2571633qkc.42.2019.11.22.10.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 10:09:34 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iYDN7-0000ZP-TP; Fri, 22 Nov 2019 14:09:33 -0400
Date:   Fri, 22 Nov 2019 14:09:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     liweihang <liweihang@hisilicon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH rdma-core 1/7] libhns: Fix calculation errors with
 ilog32()
Message-ID: <20191122180933.GE7448@ziepe.ca>
References: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
 <1574299169-31457-2-git-send-email-liweihang@hisilicon.com>
 <678F3D1BB717D949B966B68EAEB446ED300CC8A5@dggemm526-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED300CC8A5@dggemm526-mbx.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 22, 2019 at 02:58:44AM +0000, Zengtao (B) wrote:
> > From: linux-rdma-owner@vger.kernel.org
> > [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Weihang Li
> > Sent: Thursday, November 21, 2019 9:19 AM
> > To: jgg@ziepe.ca; leon@kernel.org
> > Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Linuxarm
> > Subject: [PATCH rdma-core 1/7] libhns: Fix calculation errors with ilog32()
> > 
> > Current calculation results using ilog32() is larger than expected, which
> > will lead to driver broken. The following is the log when QP creations
> > fails:
> > 
> > [   81.294844] hns3 0000:7d:00.0 hns_0: check SQ size error!
> > [   81.294848] hns3 0000:7d:00.0 hns_0: check SQ size error!
> > [   81.300225] hns3 0000:7d:00.0 hns_0: Sanity check sq size failed
> > [   81.300227] hns3 0000:7d:00.0: hns_roce_set_user_sq_size error for
> > create qp
> > [   81.305602] hns3 0000:7d:00.0 hns_0: Sanity check sq size failed
> > [   81.305603] hns3 0000:7d:00.0: hns_roce_set_user_sq_size error for
> > create qp
> > [   81.311589] hns3 0000:7d:00.0 hns_0: Create RC QP 0x000000
> > failed(-22)
> > [   81.318603] hns3 0000:7d:00.0 hns_0: Create RC QP 0x000000
> > failed(-22)
> > 
> > Fixes: b6cd213b276f ("libhns: Refactor for creating qp")
> > Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> >  providers/hns/hns_roce_u_verbs.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/providers/hns/hns_roce_u_verbs.c
> > b/providers/hns/hns_roce_u_verbs.c
> > index 9d222c0..bd5060d 100644
> > +++ b/providers/hns/hns_roce_u_verbs.c
> > @@ -645,7 +645,8 @@ static int hns_roce_calc_qp_buff_size(struct
> > ibv_pd *pd, struct ibv_qp_cap *cap,
> >  	int page_size = to_hr_dev(pd->context->device)->page_size;
> > 
> >  	if (to_hr_dev(pd->context->device)->hw_version ==
> > HNS_ROCE_HW_VER1) {
> > -		qp->rq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_rq_wqe));
> > +		qp->rq.wqe_shift =
> > +				ilog32(sizeof(struct hns_roce_rc_rq_wqe)) - 1;
> > 
> >  		qp->buf_size = align((qp->sq.wqe_cnt << qp->sq.wqe_shift),
> >  				     page_size) +
> > @@ -662,7 +663,7 @@ static int hns_roce_calc_qp_buff_size(struct
> > ibv_pd *pd, struct ibv_qp_cap *cap,
> >  	} else {
> >  		unsigned int rqwqe_size = HNS_ROCE_SGE_SIZE *
> > cap->max_recv_sge;
> > 
> > -		qp->rq.wqe_shift = ilog32(rqwqe_size);
> > +		qp->rq.wqe_shift = ilog32(rqwqe_size) - 1;
> > 
> >  		if (qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE || type ==
> > IBV_QPT_UD)
> >  			qp->sge.sge_shift = HNS_ROCE_SGE_SHIFT;
> > @@ -747,8 +748,8 @@ static void hns_roce_set_qp_params(struct
> > ibv_pd *pd,
> >  		qp->rq.wqe_cnt =
> > roundup_pow_of_two(attr->cap.max_recv_wr);
> >  	}
> > 
> > -	qp->sq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_send_wqe));
> > -	qp->sq.shift = ilog32(qp->sq.wqe_cnt);
> > +	qp->sq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_send_wqe)) - 1;
> > +	qp->sq.shift = ilog32(qp->sq.wqe_cnt) - 1;
> 
> One suggestion, it's better to introduce a new micro instead of ilog32(x) -1.

Is the -1 even correct?

I would have guessed something called shift wants to be:

   shift = ilog32(qp->sq.wqe_cnt - 1)

Such that 
   1 << shift == wqe_cnt
       When wqe_cnt is a power of two.
   1 << shift > wqe_cnt
       When wqe_cnt is not a power of two.

Jason
