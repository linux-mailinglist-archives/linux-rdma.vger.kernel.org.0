Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6C6C6A97
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 15:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCWOS5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 10:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjCWOSh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 10:18:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE3A3432E
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 07:18:35 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id bz27so14909163qtb.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679581114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYTNFeVT3CXLF3jhqVn1RwVVTLkofE6hdi4n929iSZM=;
        b=ng51RbmAsPs+QuObcG24LoWwb2j2sYlCU/3vcu+WBBMhFsAGPyt0s2XQBvCsB+aZMG
         To761Qfs75pLQuORrMu4/pHyNLEQzjWhTmmmxm/ymkx+beN+EvTH8qCY+4fCaZnoABAi
         KJn22MYu5QuR3TyMNJpDGzPR52hk+nkedKmVvaFG4XtLcT1sPONKbRwrsCvtPhagegZI
         d8sICuF/fYthHp9b/rlJwpVYZ2TV/LAlUCNER+dB1fJFO4YKn42MtwfCQdvwaOlR+98/
         NniJWQQKRGsf/V+GiHm8X1M+gjleHrmm1b9u8uhnHk/VMN98yKajd7ATlLDP5haBMJbf
         ARRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679581114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYTNFeVT3CXLF3jhqVn1RwVVTLkofE6hdi4n929iSZM=;
        b=Il6QkLm0wsjwU/s2ZgxgprZSwOsktNWna8hDFy+/blo/+Os4Zfl5SvmHDaM6VTqMeu
         cEDZfHragJE6viEz8t3D5DPx9/N77I34/0QbPbE9bwCU5BsBBOKvfrO0WoNRBexcv1qa
         OfdyxDVcB2L9LztKQwNndj2814VYFoHWQfp1a+XMO7wHf560hfB1sZ/KvZ7gFVFtYHk0
         ELdvwp36i2mzprL8oQ+OC3wMAWDlPj2m1BCsVRYx09MoDi5HSyOuKT4Vueko9N7gMJKH
         9KRu1p5eIbA69QLlM3NeOE3KhVkUA1HKOyUz2mP+nGbsYfcMt6/QmxZ1M4uJktbTmb9A
         DeRg==
X-Gm-Message-State: AO0yUKVEqjhTPdoNw7A6Px+UXmfgWrXRTNjrEStbFoI8kZfnYdv/cL5S
        1/3Wm8cNOkUcGPOt9CNg5EvJ8w==
X-Google-Smtp-Source: AK7set++ugOe9Nbv+iBuc8vNm64iNvl76qhhqf3P2hiL+9ZMn8oyRs6TNzHe2v4aDATU+s78e9G52g==
X-Received: by 2002:a05:622a:13cc:b0:3db:814b:f9d2 with SMTP id p12-20020a05622a13cc00b003db814bf9d2mr11822349qtk.37.1679581114128;
        Thu, 23 Mar 2023 07:18:34 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x26-20020ac86b5a000000b003bfa2c512e6sm11867199qts.20.2023.03.23.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 07:18:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pfLlw-001FSF-PK;
        Thu, 23 Mar 2023 11:18:32 -0300
Date:   Thu, 23 Mar 2023 11:18:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Message-ID: <ZBxfuN66QYgFrJd/@ziepe.ca>
References: <ZBm/deQgMYfdPt/u@ziepe.ca>
 <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
 <ZBrsexPDqDIej/2/@ziepe.ca>
 <6c982b76-61b2-7317-ab76-8ff0b4fb4471@linux.alibaba.com>
 <ZBsKHBN2NIFA6/YD@ziepe.ca>
 <8c446431-9f86-7267-6051-9c016e23215e@linux.alibaba.com>
 <ZBw9pmTtAlNVffuA@ziepe.ca>
 <243f9c6f-72ab-c503-33be-24e58e1d4ddf@linux.alibaba.com>
 <ZBxOoxynDEql7wHT@ziepe.ca>
 <8677b42c-3f61-b83d-cd97-68591778944d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8677b42c-3f61-b83d-cd97-68591778944d@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 23, 2023 at 10:10:25PM +0800, Cheng Xu wrote:
> 
> 
> On 3/23/23 9:05 PM, Jason Gunthorpe wrote:
> > On Thu, Mar 23, 2023 at 08:33:53PM +0800, Cheng Xu wrote:
> >>
> >>
> >> On 3/23/23 7:53 PM, Jason Gunthorpe wrote:
> >>> On Thu, Mar 23, 2023 at 02:57:49PM +0800, Cheng Xu wrote:
> >>>>
> >>>>
> >>>> On 3/22/23 10:01 PM, Jason Gunthorpe wrote:
> >>>>> On Wed, Mar 22, 2023 at 09:30:41PM +0800, Cheng Xu wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 3/22/23 7:54 PM, Jason Gunthorpe wrote:
> >> <...>
> >>>>
> >>>> It's much clear, thanks for your explanation and patience.
> >>>>
> >>>> Back to erdma context, we have rethought our implementation. For QPs,
> >>>> we have a field *wqe_index* in SQE/RQE, which indicates the validity
> >>>> of the current WQE. Incorrect doorbell value from other processes can
> >>>> not corrupt the QPC in hardware due to PI range and WQE content
> >>>> validation in HW.
> >>>
> >>> No, validating the DB content is not acceptable security. The attacker
> >>> process can always generate valid content if it tries hard enough.
> >>>
> >>
> >> Oh, you may misunderstand what I said, our HW validates the *WQE* content,
> >> not *DB* content. The attacker can not generate the WQE of other QPs. This
> >> protection and correction is already implemented in our HW.
> > 
> > Why are you talking about WQEs in a discussion about doorbell
> > security?
> 
> Malicious doorbell will corrupt the head pointer in QPC, and then invalid WQEs
> will be processed. My point is that WQE validation can correct the head pointer
> carried in malicious doorbell, and can prevent such attack.

No, if the head pointer is incorrect an attack can stall the QP by
guessing a head pointer that is valid but before already submitted
WQEs.

There is no WQE based recovery for such a thing.

Jason
