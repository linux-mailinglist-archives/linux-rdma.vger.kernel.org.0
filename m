Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95614255198
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Aug 2020 01:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0Xd6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 27 Aug 2020 19:33:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:6513 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH0Xd6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 19:33:58 -0400
IronPort-SDR: 8sGdHUxxeuQ2EZjYWRftLqwQA78358bGlwU8nQRy56VyPX3H5rJE9jk+Qrr+wuB3i+WnSIByLU
 BRh0SDyOPRBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="157607026"
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="157607026"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 16:33:58 -0700
IronPort-SDR: iCK92PXKtcB+LmAJ/5szm30HyIdWrydetuR4ap/zpnGWkp0c3D1x43Amiij5Kq/7WAS5SXw5w8
 j70BqMRd66nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,361,1592895600"; 
   d="scan'208";a="323791425"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2020 16:33:57 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 16:33:54 -0700
Received: from orsmsx102.amr.corp.intel.com (10.22.225.129) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 16:33:54 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.10]) with mapi id 14.03.0439.000;
 Thu, 27 Aug 2020 16:29:45 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
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
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: RE: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Thread-Topic: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Thread-Index: AQHWegH0XKmutqff+UKxzS7b3hqhGKlI8IqAgAA9SQCAAAVogIAAD4EAgAAHFYCAAAM4AIAABYUAgAAq+NCAAT9EgIAANDbwgAFnKwD//9EWYA==
Date:   Thu, 27 Aug 2020 23:29:44 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7010712DBEB@ORSMSX101.amr.corp.intel.com>
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
 <20200827121306.GM24045@ziepe.ca>
In-Reply-To: <20200827121306.GM24045@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
> deallocate
> 
> On Thu, Aug 27, 2020 at 02:06:03AM +0000, Saleem, Shiraz wrote:
> 
> > Which then boils down do we just keep a simpler definition of the API
> > contract -- driver can just return whatever the true error code is?
> 
> No, that was always wrong. In almost every case returning codes from destroy is a
> driver bug, flat out. It causes kernel leaking memory/worse and unrecoverable
> userspace failures.
> 
seems like we are opening a can then.

I can see a new provider seeing the int return type and returning error codes.
And maybe being stumped by seeing some providers ignoring device errors and faking a success.
And one provider returning error codes.
More so, how are we going to document the ambiguous definition of this API,
and who can and cannot report error codes?


