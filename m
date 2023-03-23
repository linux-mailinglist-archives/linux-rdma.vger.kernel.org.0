Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F66C6917
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 14:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCWNGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 09:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjCWNGB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 09:06:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD232512
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 06:05:41 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t19so12280528qta.12
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679576741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQBvdhaatrTIpd7w0nm5kNjSaBmo0f+jZPuaN2J8FGQ=;
        b=XhdwJ8+reRLrLFNL+V8kiWYKNQ+gY42OIp8SSkCHJidrg2IjP3e7ZXnNijjBwZuzC+
         ZR6dkBOP/Ke3RTJWAtGT4H8F8DBRruUwlBMOCnTc5mkHoB6oBJ2nlA4EOytSrWSe7a7i
         5lK7mPO5xe0x+gg+q4zn3ckXkz5wBtJcUfvnZHaaygHe57+j6zKnJmE+5GR5f+Icygfk
         T1rE+jfzZTWybb/pdMDWGicAk8RFaysQ73sk4yD40BVU7QT3bst+ZBiznC1x6eVDfRFe
         BxKBQomSPHja3oUXa7b2+bB2U3fCFION6ognotkREvfJjwt16RcjtvhjqYVpBx1/mBVr
         3fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQBvdhaatrTIpd7w0nm5kNjSaBmo0f+jZPuaN2J8FGQ=;
        b=q+1ugS0QRc3AHDGu8qCiUXuJ7T3Vih9UfMPF81BVyYiI6le91r2JUT+rxV82swMGju
         Oj3NG3aFvdFjwqXlDo9wG/kodD1elkrmQVP/yIMZZ4h9Wu4dixjTiy/fhFIYRt94oRSi
         UAN5mDfVSy4LGvz8vO+9n4T1wxIzll+EEw1AqF0u8Yo9O1B4h+tyvTPTRIa1MwGxYaJX
         pnRm1tQK5RnY4yLnI+NoTfp7xSlMJIwe6gXlLP7cX71/+juANgT+JrqjmM+5xcB9dEl/
         IXcXtcq7rpbNhUpeK0NXpuXpaJP5WPqmZJ5NStiJ6sXpNFb1M/56jlmpG4Ho+VraVMq9
         zYVw==
X-Gm-Message-State: AO0yUKV9eEBHZlCcV60rUBXj8g3gZ2igE/5yj2cGUmINFGhrkaXNDjDf
        eEt5hkfQKOct52ef8d5DuhOa6A==
X-Google-Smtp-Source: AK7set9wYg28VVDSG6VK+ec35RuTEbRfC4F/kdL0fbXLH+MaaHFN6f8/HHLgU6elgHDP0ElW3uLAGg==
X-Received: by 2002:ac8:7f92:0:b0:3bf:c474:df98 with SMTP id z18-20020ac87f92000000b003bfc474df98mr10318424qtj.56.1679576741007;
        Thu, 23 Mar 2023 06:05:41 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id j20-20020ac85514000000b003b82489d8acsm1734863qtq.21.2023.03.23.06.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:05:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pfKdP-001D2h-Ny;
        Thu, 23 Mar 2023 10:05:39 -0300
Date:   Thu, 23 Mar 2023 10:05:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Message-ID: <ZBxOoxynDEql7wHT@ziepe.ca>
References: <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal>
 <ZBm/deQgMYfdPt/u@ziepe.ca>
 <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
 <ZBrsexPDqDIej/2/@ziepe.ca>
 <6c982b76-61b2-7317-ab76-8ff0b4fb4471@linux.alibaba.com>
 <ZBsKHBN2NIFA6/YD@ziepe.ca>
 <8c446431-9f86-7267-6051-9c016e23215e@linux.alibaba.com>
 <ZBw9pmTtAlNVffuA@ziepe.ca>
 <243f9c6f-72ab-c503-33be-24e58e1d4ddf@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243f9c6f-72ab-c503-33be-24e58e1d4ddf@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 23, 2023 at 08:33:53PM +0800, Cheng Xu wrote:
> 
> 
> On 3/23/23 7:53 PM, Jason Gunthorpe wrote:
> > On Thu, Mar 23, 2023 at 02:57:49PM +0800, Cheng Xu wrote:
> >>
> >>
> >> On 3/22/23 10:01 PM, Jason Gunthorpe wrote:
> >>> On Wed, Mar 22, 2023 at 09:30:41PM +0800, Cheng Xu wrote:
> >>>>
> >>>>
> >>>> On 3/22/23 7:54 PM, Jason Gunthorpe wrote:
> <...>
> >>
> >> It's much clear, thanks for your explanation and patience.
> >>
> >> Back to erdma context, we have rethought our implementation. For QPs,
> >> we have a field *wqe_index* in SQE/RQE, which indicates the validity
> >> of the current WQE. Incorrect doorbell value from other processes can
> >> not corrupt the QPC in hardware due to PI range and WQE content
> >> validation in HW.
> > 
> > No, validating the DB content is not acceptable security. The attacker
> > process can always generate valid content if it tries hard enough.
> >
> 
> Oh, you may misunderstand what I said, our HW validates the *WQE* content,
> not *DB* content. The attacker can not generate the WQE of other QPs. This
> protection and correction is already implemented in our HW.

Why are you talking about WQEs in a discussion about doorbell
security?

WQE's are read via DMA from their SQ/RQs - that path doesn't have a
doorbell security problem.

The issue comes if you try to deliver the WQE via a doorbell write.

Jason
