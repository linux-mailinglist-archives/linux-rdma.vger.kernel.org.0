Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881B12C66AD
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 14:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgK0NVS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 08:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgK0NVR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 08:21:17 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6447AC0613D4
        for <linux-rdma@vger.kernel.org>; Fri, 27 Nov 2020 05:21:17 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id v143so4285805qkb.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Nov 2020 05:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTDFLrnl9vX9Zvvb4FaH+uC594xA1aQc7rYV3xdenpQ=;
        b=SjLEVoVow9UoGXkcy2D+xe4iSlcs8aUZnTDh4ELjygwazvU4/hELHeoEnpGyOvh/Fu
         oqNHTuryHA7UI0DebyvooQpVoqpx0vRH4JkqbHttNosdgpS64jqE8/qwTePyyPYMG6ZU
         PtmjJDgPKNzMzuSkakkaLa0fHwGcFXkveNciyjmuIWACzjrqpOyPgBNduSf+vNlgJ/QQ
         QY+SSFzm0G+dVZ1QNRgz1X2KdL0nLTkPOPC7WznBCzbeZ288LPIZQTZy1TfVYSPoAMzz
         egZGB8M5YDzGPayKV/alezZzmKnUIUhkjqoj+pEZ6orChOXti3FGqg3smsRVLEXOD0DU
         BxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTDFLrnl9vX9Zvvb4FaH+uC594xA1aQc7rYV3xdenpQ=;
        b=eCDtFfxOCcslchGBJJW2IaLcSXEbbox+I6x3Mnxs3xd19VbJ6cHO6gq5dFYlIGZ53+
         Vp3g2S8/M3Vh/CtvsRgSgtHgpJf4HceakW2HyjvP4aAsrCsbQ+jWyLgc7AcDlC69Sool
         F2U2N7U4bPVaGWlKaP4+1Irk2gtUzONdU4EpA5wj6LeztB1EIj47L8rQd8AeJxMIioIe
         b5WtalhYR1QSaoIErWrzJmtEpp2X7gT9CBA1rhrUkT20XtIebzEcZkI4FelULmHCmyOJ
         kVJmLprVSnomqeoY1Th+8DHcyzzrNmXojCQKkt9p15m9TkD6KyTekGrC0vfboI38KP9d
         5RHg==
X-Gm-Message-State: AOAM530GZw5EZAVmx3HUXfEfRAtIpmVwV1159spsww7ChxyNfWq64iL2
        sK9+j7jdh/SRFY7/SUGhsvWVMw==
X-Google-Smtp-Source: ABdhPJyZuAQo/nSHBrvXU6mE5iSNQiQDNAzZd6EsBcgmRegGUUc2fMB9/67M+xfr3aE3Z2/l3F+ieA==
X-Received: by 2002:a37:a312:: with SMTP id m18mr8616507qke.268.1606483276658;
        Fri, 27 Nov 2020 05:21:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p22sm5817544qtu.61.2020.11.27.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:21:15 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kidgY-002h7q-Vw; Fri, 27 Nov 2020 09:21:15 -0400
Date:   Fri, 27 Nov 2020 09:21:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Add support for UD inline
Message-ID: <20201127132114.GY5487@ziepe.ca>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
 <1605526408-6936-8-git-send-email-liweihang@huawei.com>
 <20201118191051.GL244516@ziepe.ca>
 <7a7ee7427b68488f98ebc18d5b7c4d75@huawei.com>
 <20201126192428.GA547165@nvidia.com>
 <35582a7f2b924a6980403f2901e7bf31@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35582a7f2b924a6980403f2901e7bf31@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 27, 2020 at 09:55:11AM +0000, liweihang wrote:
> On 2020/11/27 3:24, Jason Gunthorpe wrote:
> > On Thu, Nov 19, 2020 at 06:15:42AM +0000, liweihang wrote:
> >> On 2020/11/19 3:11, Jason Gunthorpe wrote:
> >>> On Mon, Nov 16, 2020 at 07:33:28PM +0800, Weihang Li wrote:
> >>>> @@ -503,7 +581,23 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
> >>>>  	if (ret)
> >>>>  		return ret;
> >>>>  
> >>>> -	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
> >>>> +	if (wr->send_flags & IB_SEND_INLINE) {
> >>>> +		ret = set_ud_inl(qp, wr, ud_sq_wqe, &curr_idx);
> >>>> +		if (ret)
> >>>> +			return ret;
> >>>
> >>> Why are you implementing this in the kernel? No kernel ULP sets this
> >>> flag?
> >>
> >> Sorry, I don't understand. Some kernel users may set IB_SEND_INLINE
> >> when using UD, some may not, we just check this flag to decide how
> >> to fill the data into UD SQ WQE here.
> > 
> > I mean if you 'git grep IB_SEND_INLINE' nothing uses it. 
> > 
> > This is all dead code.
> > 
> > How did you test it?
> > 
> > Jason
> > 
> 
> Hi Jason,
> 
> We have tested it with our own tools. After running 'git grep IB_SEND_INLINE',
> I found following drivers refer to this flag:
> 
> bnxt_re/cxgb4/i40iw/mlx5/ocrdma/qedr/rxe/siw
> 
> So I'm still a bit confused. Do you mean that no kernel ULP uses UD inline or
> the IB_SEND_INLINE flag? 

Yes

> Should current related codes be removed?

Quite possibly, though rxe and siw might be using it as part of the
uAPI

> I also found a very old discussion about removing this flag, but there was no
> futher information:
> 
> https://lists.openfabrics.org/pipermail/general/2007-August/039826.html

Right, it has been unused for a very long time, I doubt it will ever
get used

Jason
