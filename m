Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C6254830
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH0O7y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 10:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgH0MNT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:13:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58396C061264
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:13:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o196so5054786qke.8
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NVgMAvwSkRVpVqhmGwbXBmebtM3j4g3jGyyptImAh84=;
        b=U4bSinliGIBk9YsT1l8+TkYscTtSFt4w/TeAYLtseGwCwUIndXcbrcDHwSVYbfBLFp
         AZSFeLqLBApnvfseJtldjCgUZDDVSwKINeYC2kgbyYtvX48TRZUJA1Rc+q45Iw/C1KOD
         bh0LxlyH5j/C+VMhBx5oyrPmewnm85foXtP4uPTA9kuJVbP+WTRjL4yA8Vdpgkzw6J8a
         hZ1a6UBsp99RVpSyhOGZtOMKgDcpteu/TdPQrr4Bj+4lqhyemvWlEBweufZDyQdFFnr6
         K4LQUw5WY9F9yKOxXLU+INzN+v3oLyCOgizrU3LqHz755y/TIqtFcvcwAgqbfM6/rbQ3
         8UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVgMAvwSkRVpVqhmGwbXBmebtM3j4g3jGyyptImAh84=;
        b=eozszdlUtQyY5b1yPIN10Y3o7mjMDeH30qEDd6qyMwxcQjYP+8lkAK12IpdBflidBp
         X+hAtT7mde6OasUyjvkSULtlHWa6W/brKjEl1zbL3pf37MN2IQgcmc2DdZ9AnJDdNB4d
         M1+JH5961NbGXT3ge1rVO0cSGNL7S7360FZKBcOcuoGDYK6L2TlmC4v6XUK6lDaTW0CS
         dS2juNzk230e+3KElL95P/IA9jgXnN72t+Oey/OTVXnU/OkJQ3D1CXnd0Q9sVaRK5rtQ
         h8oXTXfJ/eZJn38S68/rlTUw7HwRiP+mOlzD5RCm4Xc+/DKPZhwhtwBQ46tQW69LJHyu
         +vgg==
X-Gm-Message-State: AOAM5313+0O8eu5MLByItkN2onX5g7G1ovPcF0BYhwqgCqNDCy6cDDem
        mnIg8mYvmzBAz2bb2TaSULqqyw==
X-Google-Smtp-Source: ABdhPJy3vMsKT+NmNB9Dcn1vgO0PcJ/ZddVHy3pb3fTTA34BJjXpCLIwaULxBF9wP3XjGQTkaFMO2g==
X-Received: by 2002:a37:e105:: with SMTP id c5mr5218388qkm.150.1598530387564;
        Thu, 27 Aug 2020 05:13:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g13sm1553087qki.62.2020.08.27.05.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:13:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBGmA-00GoFl-8m; Thu, 27 Aug 2020 09:13:06 -0300
Date:   Thu, 27 Aug 2020 09:13:06 -0300
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
Message-ID: <20200827121306.GM24045@ziepe.ca>
References: <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
 <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
 <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
 <20200826114043.GY1152540@nvidia.com>
 <9DD61F30A802C4429A01CA4200E302A7010712C8EC@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7010712C8EC@ORSMSX101.amr.corp.intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 02:06:03AM +0000, Saleem, Shiraz wrote:

> Which then boils down do we just keep a simpler definition of the
> API contract -- driver can just return whatever the true error code
> is?  

No, that was always wrong. In almost every case returning codes from
destroy is a driver bug, flat out. It causes kernel leaking
memory/worse and unrecoverable userspace failures.

Jason
