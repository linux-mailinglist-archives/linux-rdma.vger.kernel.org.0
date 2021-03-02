Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF532A7F9
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573405AbhCBQtz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 11:49:55 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19045 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbhCBAEy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 19:04:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d80f80001>; Mon, 01 Mar 2021 16:04:08 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 00:04:07 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 00:04:05 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Mar 2021 00:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBRqZoA6uEws+B/yEqxxckw+W00glX3xHhBut5QevM0AQAEKGMKoiH4izM1s73xIaBic0co66wRsUzWxrKMz1naEdgKEFPgR+/p8YHzl+WYpGZXj5l0qo3SaEYcO9vEM9mdOIKQ4/Vn8RCOrbs5laH1JRRldebBXPTXTMNfUKPKLEW25lYQzLogMrxnQWnUGSNx1Tv98xQgPgV60AzaqR31IcKO4Fip1oZYLmf7MEVnF3gnDf8KQR8FzpQEtSo2E/XnBKupn4vvnIb7tmkU0X9h+JszfBJA6Hn1k+g/ki2BdcZAVi6ZD01ap52i2gHRuKonrES3KYu9ahQwwScv05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoqRdjaoLORz2g5MDO+9yfoXQeZzFmFmZ5XLKG2hrSE=;
 b=ZLvVku1f66me2n2J53h0guXNpZEsp95BAxUznESBxRN1KDfS82WGljOVEMPw6THHlp3E4hH6gC4Y5qqTyVAmKAfjL87g1CJ0f+/fm6Qh1QGRSAx6klyBGi4Nr6/8eHxI6KX7Yb1iUfrpGX0JV7LYhgYroQ3834xagdF/XyIxHzJtYJ2nUb+6Cmb10KgmsRmahf+0b/Q+OI/fsta3WaLfgtjV36N14efVpEl1bhW03EbDvPLmnDFzk2kUAFT5k/NZebiTSvB3+Jl8mjpzl0JisENhuw2sLUZAHxHKnDfpuCFvBETE4ansMq9EYiOBTqQV1xVL2R6AjjE8nZEzbOCUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 00:04:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Tue, 2 Mar 2021
 00:04:02 +0000
Date:   Mon, 1 Mar 2021 20:04:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>
Subject: Re: [PATCH for-next 0/2] Host information userspace version
Message-ID: <20210302000400.GB4247@nvidia.com>
References: <20210105104326.67895-1-galpress@amazon.com>
 <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
 <20210121183512.GC4147@nvidia.com>
 <206d8797-0188-5949-aaaf-57a6901c48d9@amazon.com>
 <20210127165734.GQ4147@nvidia.com>
 <41cf157b-d36b-06a2-a204-090848e44175@amazon.com>
 <587c0ea6-97a3-9ced-cb0e-6464986b800d@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <587c0ea6-97a3-9ced-cb0e-6464986b800d@amazon.com>
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:208:e8::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 00:04:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGsW8-003CgD-IF; Mon, 01 Mar 2021 20:04:00 -0400
X-MS-Exchange-MinimumUrlDomainAge: github.com#4893
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614643448; bh=UoqRdjaoLORz2g5MDO+9yfoXQeZzFmFmZ5XLKG2hrSE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:
         X-MS-Exchange-MinimumUrlDomainAge:X-Header;
        b=f3eN/e3eet+6hzTKAYNSX2dEc4YVZWX0Bs+7MB3avfrfhg0qtjiN9VAI2ZyOMZ+Lm
         DR9Ot7DpLnmy6h1jss0LfHzPObeZzb69XSyKtyI8DBjoQNYP7kcYx3dyqlaUcOwzHQ
         2JCDSSJbQRyzXbBETQIZ6rVlUbFmkx2oAtb/wTqyNHRcOmCdUSYDr3nPCXzrKI54xR
         moVCOPCAbpfoWgq4E7WpxqEpVS7aqrs8NROJHXXP/kdQJDFj4QGePcVusg+OlCL7E7
         zuVyXqz1V8U94/fsCsHeiF15MohnvSvtdFU/k1vv1+bskKwK85gHcM0jm7ZjQ2yQ9M
         BNKVOCaJn/4dw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 28, 2021 at 11:56:01AM +0200, Gal Pressman wrote:
> On 27/01/2021 19:53, Gal Pressman wrote:
> > On 27/01/2021 18:57, Jason Gunthorpe wrote:
> >> On Thu, Jan 21, 2021 at 09:40:49PM +0200, Gal Pressman wrote:
> >>> On 21/01/2021 20:35, Jason Gunthorpe wrote:
> >>>> On Tue, Jan 19, 2021 at 09:17:14AM +0200, Gal Pressman wrote:
> >>>>> On 05/01/2021 12:43, Gal Pressman wrote:
> >>>>>> The following two patches add the userspace version to the host
> >>>>>> information struct reported to the device, used for debugging and
> >>>>>> troubleshooting purposes.
> >>>>>>
> >>>>>> PR was sent:
> >>>>>> https://github.com/linux-rdma/rdma-core/pull/918
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Gal
> >>>>>
> >>>>> Anything stopping this series from being merged?
> >>>>
> >>>> Honestly, I'm not very keen on this
> >>>>
> >>>> Why does this have to go through a kernel driver, can't you collect
> >>>> OS telemetry some other way?
> >>>
> >>> Hmm, it has to go through rdma-core somehow, what sort of component can
> >>> rdma-core interact with to pass such data? The only one I could think of is the
> >>> RDMA driver :).
> >>>
> >>> As I said, I get your concern, I was going on and off about this as well, but
> >>> the userspace version is a very useful piece of information in the context of a
> >>> kernel bypass device. It's just as important as the kernel version.
> >>> I agree that this is not the place to pass things like gcc version, but I don't
> >>> think that's the case here :).
> >>
> >> Well, if we were to do this for mlx5 we'd want to pass UCX and maybe
> >> other stuff, it seems like it gets quickly out of hand.
> > 
> > Agree, that's why I think this should be limited to things in rdma-core's reach,
> > sounds like a reasonable limit to me.
> > 
> >> I think telemetry is better done as some telemetry subsystem, not
> >> integrated all over the place
> > 
> > Interesting, but that would still be all over the place as each package would
> > have to report its version to that telemetry driver.
> > 
> > And since this currently doesn't exist, should we stay without a solution?
> > Specifically talking about rdma-core version, do you think it could be merged?
> > 
> 
> Jason?

I'm not keen on it, it doesn't work well for other use-cases, it seems
too hacky.

Jason
