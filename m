Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765B457D3BF
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiGUS6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiGUS6o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 14:58:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BEC88F2A
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 11:58:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x11so1953568qts.13
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3No9HCPLFUQbzvMOU8VidEPmO3wf6Gb+xOOVMfDZezA=;
        b=di4nVEHq0YFKNJ1jlNyyes8HFShcxOwPXmxbwz3OMtTgnqPOb/bTZXUVl6LMAAKVRQ
         fzp7IWrlEI1dYkBq0n4hLRrQz3aiy8eMgjsOS3d/hVINzZHtcIyKGPLPUWke8nB0Mw6h
         4VzD2wpfkKSSUnnz95VdwAfQhqAM6YPsywPgNzdbc0Ye/5c6f+RHDKMlFv8/8uSKUsM6
         jvUnbVwmEHhCexn6/cjPdcVznkNDDvljLIApZwzw5VzzP3YPCAKoIuFzC46yxIvS43Fd
         HLWj8vcuFpKN6yVDnd4WUbs41dZfZCFDa0kS2igaX/yPY7kxNzDWHpZvBXlGsp3m4JOV
         3UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3No9HCPLFUQbzvMOU8VidEPmO3wf6Gb+xOOVMfDZezA=;
        b=anUxV5nz47zuHn7GYfO70NBvTesEuxlOsD0yELtOfqZ1dhlvkj14uOP+/0JUi9xhbI
         aZCvJI9MWzVINyWdPOBEgCR6axQ/k6OgqaAPF8f9pOt1DYlIM+OJYB0FCVKTUkuxWYO4
         IcLDz+czNtRsm9dEcYcCiRBu50+q1v35I7yEU2MEX7OsmfncHKoNtpj5dLKKPx8MSwrQ
         ks5MmlYJRIhvNIQuIQaOl/6R7ezejTz1spK96CCrRIZaer1YhzCkSUTd2wsAC9+NYoi2
         KxlYZRRNLObmHtKgHtzqDEiOQRkF3ffHfyTux1GP41OvUmYOpmVf8k+bXl7Qbzw7V+jy
         4lWQ==
X-Gm-Message-State: AJIora9cIDexzoKc32gL1jZWikEiJGPeJVasOKy7zIZ+Wd8qu5mKqEVu
        PKbUM9UaDj6GFBB2hpjxqbwVX1IawpnJBQ==
X-Google-Smtp-Source: AGRyM1s98J6Z2TTKoaj0uWr+HjnvDWkgKDyRPNPP3udg+CE/uWjPTKOsANCPECrr6VFKyj05cc8aJQ==
X-Received: by 2002:ac8:7dcc:0:b0:31e:f21c:45b9 with SMTP id c12-20020ac87dcc000000b0031ef21c45b9mr16201428qte.133.1658429922397;
        Thu, 21 Jul 2022 11:58:42 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a400b00b006b60c965024sm2069517qko.113.2022.07.21.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 11:58:41 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1oEbNg-000291-PA; Thu, 21 Jul 2022 15:58:40 -0300
Date:   Thu, 21 Jul 2022 15:58:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ajay Sharma <sharmaajay@microsoft.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        Mahmoud Elhaddad <Mahmoud.Elhaddad@microsoft.com>
Subject: Re: CQ creation for RDMA use case
Message-ID: <20220721185840.GD6833@ziepe.ca>
References: <BL1PR21MB32831892955F3493715EEE33D6869@BL1PR21MB3283.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR21MB32831892955F3493715EEE33D6869@BL1PR21MB3283.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 12, 2022 at 07:55:21PM +0000, Ajay Sharma wrote:
>    Hello,
> 
>    We have a situation where the hardware treats cq creation differently
>    when attaching it to RAW_QP use case vs the RC_QP use case. The
>    situation is as follows :
> 
> 
>    When creating the cq for RAW_QP_TYPE use case , the hw requires that
>    memory be registered with the hw but it does not yet attaches it to the
>    qp meaning it does not yet allocate any hw side resources for the cq.
> 
>    The hardware will allocate resources for this qp type only when it
>    see’s the work queue creation request and that’s when it allocates
>    resources for both cq and wq.
> 
> 
>    When creating cq for the RC_QP_TYPE use case the hardware creates
>    resources immediately on cq creation request.
> 
> 
>    The problem is from the user mode side there is no way to tell whether
>    this cq is intended for RAW QP use case or RC QP use case. Can we add a
>    flag in the  ibv_cq_init_attr_ex to differentiate the use case we are
>    trying to address.
> 
>    We have explored the option of customizing in the firmware side and at
>    this point it seems a very expensive operation and would like to avoid
>    that.

I don't have a good advice for you, this is very non-compliant if CQs
can only be used in certain configurations. The entire verbs is
designed around the idea that the CQ is a sharable object - having a
device that creates a CQ for every queue is very far away.

Why can you not correct this?

A flag is not so sufficient, it is an entire set of bad behavior that you
have to opt into.

You may consider a dv for creating a QP/CQ pair if that models your
HW.

Jason
