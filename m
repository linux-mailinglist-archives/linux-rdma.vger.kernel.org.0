Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9925594F
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Aug 2020 13:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgH1LZt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Aug 2020 07:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgH1LZX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Aug 2020 07:25:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208FC061234
        for <linux-rdma@vger.kernel.org>; Fri, 28 Aug 2020 04:25:22 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n18so435511qtw.0
        for <linux-rdma@vger.kernel.org>; Fri, 28 Aug 2020 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/NQ4/bZz7qnxaksjbctF5i93BXjKpBT47/DYQyeImzg=;
        b=RqIqgKzUG3WmmzdBtOFOuOYcDv4W/RN/tAvIBO+WTSCxxD8ptZs2YwD19IN/ZSxGlu
         37xMn92WHWlL1Hu8QpfdTlS+52eL5r4CuFzRU/gpIfc2HINGlb44Q4qVMAKs0dWpYvCk
         W/hDEcMeX/vlN9ClHiCGvci7CLis5fcAjJkCm6AcoyRrA/YgxPGocE+suWr0zdgKEPVt
         DJBuvXUZeCd8/dfiiLn1bOyZovoBKyVb8I/ZZxDlL8HYd2vKXwjVxf7qYfsaDwk4Nfcl
         gOLJkfwC2E5sgM96xIKf7pMRuutfJ/6KJp9gV07+bys4q5me5igsm6k+46CGqnZxI1Fx
         ryrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/NQ4/bZz7qnxaksjbctF5i93BXjKpBT47/DYQyeImzg=;
        b=MKcCnlT7JV6WFCoyOjgSS2hX67rKqBXNysTEJLJzmnb6jl7NZck8RZNJsMRBGNs/Hb
         L3r0GxetG9L8NfGtq7QtnutDRTP3U8dTE3UvW2eWoqX6KWyCf9eA329Egsx5uRGj2l75
         L6GUk+JBQdyuWjXG23LcUvWG/Tkp8eYkzS3hksEoqTmX5TVVO/HumUhhbahPN0S8c4vP
         NIJo3OmLaLzYtSOGZY5dtn7E3HBZ4Ciy8cxtsFcoGrf9RLQbl3s8h7qZWjQYuZEvQObO
         TLZimV0NBQ59STisyp4RWS9FXZ647dX8ZjFbvBiqQGx57oZ1DAUEpEZeemjIZCjlwrlU
         sWrg==
X-Gm-Message-State: AOAM530cVLHLm8ddAneQU5YfYNGQr4mXqaA3dPXNjjyNBgyhatolBKFh
        S1TOlMIe1SH9urGmGAuvHq7j4A==
X-Google-Smtp-Source: ABdhPJwuuYEd1wToUAYcVximkSyFP3MEcQB0Aw4uvLYCmURd7Uh3j79rTdbWuhRco3LSvC3RdG00VQ==
X-Received: by 2002:ac8:550f:: with SMTP id j15mr1095743qtq.26.1598613922132;
        Fri, 28 Aug 2020 04:25:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g23sm483570qke.59.2020.08.28.04.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 04:25:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBcVU-000Og5-Kf; Fri, 28 Aug 2020 08:25:20 -0300
Date:   Fri, 28 Aug 2020 08:25:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Message-ID: <20200828112520.GW24045@ziepe.ca>
References: <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
 <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
 <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
 <20200826114043.GY1152540@nvidia.com>
 <9DD61F30A802C4429A01CA4200E302A7010712C8EC@ORSMSX101.amr.corp.intel.com>
 <20200827121306.GM24045@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7010712DBEB@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7010712DBEB@ORSMSX101.amr.corp.intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 11:29:44PM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
> > deallocate
> > 
> > On Thu, Aug 27, 2020 at 02:06:03AM +0000, Saleem, Shiraz wrote:
> > 
> > > Which then boils down do we just keep a simpler definition of the API
> > > contract -- driver can just return whatever the true error code is?
> > 
> > No, that was always wrong. In almost every case returning codes from destroy is a
> > driver bug, flat out. It causes kernel leaking memory/worse and unrecoverable
> > userspace failures.
> > 
> seems like we are opening a can then.

It is not something new, it has always been like this, with these
rules. The effort to remove the return codes simply failed :(

> I can see a new provider seeing the int return type and returning error codes.
> And maybe being stumped by seeing some providers ignoring device errors and faking a success.
> And one provider returning error codes.

No, things can't ignore device failures. If the provider can't
shutdown a rouge device then it must return error, leak memory and
accept the WARN_ON. Otherwise the device will cause memory corruption
by DMA'ing to memory that has been freed. 

Having a RDMA driver that can do recovery from HW errors via device
reset is really required to close these edge cases.

I suspect no RDMA driver gets this all right today.

Jason
