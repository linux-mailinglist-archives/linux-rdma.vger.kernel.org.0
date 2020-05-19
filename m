Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F511D99BC
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgESOaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 10:30:39 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:19031
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbgESOai (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 10:30:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tot/9fupjaqwMmmc9PLDNocs6QcFS0Q9pRBBpquzejPzdZ/++AA/NqKHi2djRMu9/9Y8x0InLeMweh8AcZcZ8zfs3asB7ZueIU+iBVKWBgnyGVDATzvwxePr9IzFlGYIXIJd3CGHYCUjcepxq2Q2rTGl61Q8XT3nwkZTanKmDSmFKqYQawH4yh65jaxFRPU1y5O8eZ9QabrwoOfBEoUQu49J50tDI0keT+HngEvkjmaL4yDuytxVj9ZixyqjRfSI44LJVwqH3dae9Wt1yFudUKWizBdOq024qMsPVujxRUh7IssxbqQuD2YXzyI3HsC7kiBwnYJEBuwbp282EXTb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN75LrulFI6ctiZgU5C5dyiyC9XygHQZVQNDv1Cl2P0=;
 b=If7/UPhCaTGwrfHXwcd1xwCtjjtpqWACzcd84PSsgEraG60sjvrQ2WEm4AjnbR9D9GnEvyxwhMzkiuQdecZBmiEOX2Og8GVTkEjBVrsGb7FopB0WbF1HW9hPXRDSg2RMcf0YiHQnTT3njV3o15w95ZxhhahPGHbH7KbmVFR1d5nBb/V5roYvW1k15ounF7/M+aNB62LcjYsEEvSb5jWZlyQ5tQHH2icdYyVHCdpFuvjhFgLC+/kx+TYXnbEl0g9nGaMkd9ZzpV0TPeV1Mdw5jgCvtcEXYKGbqxmIpxX1ixcVg56lFRcvPg36QQzOCWwrbjmZhzO4HndUPUKLGytrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN75LrulFI6ctiZgU5C5dyiyC9XygHQZVQNDv1Cl2P0=;
 b=aA8m/TKNUi+CCCUccBxqfAvkPzX4ZJyObrelU/gK70ypFoJpPeZgkpXAt4zOhULYMNXslWgayvvebU5KkyvGUq6WcGyQPJ95ZEwUPd0PIafyYt22lF3CLQmwmF18+y6Hwi1rWwXiJM3aC1Y1nUxP5B4RXNhQRUESeMfpXTBQX/E=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4317.eurprd05.prod.outlook.com (2603:10a6:803:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 14:30:34 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 14:30:34 +0000
Date:   Tue, 19 May 2020 11:30:30 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, dledford@redhat.com, sagi@grimberg.me,
        israelr@mellanox.com, shlomin@mellanox.com,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
Message-ID: <20200519143030.GA23839@mellanox.com>
References: <20200514120305.189738-1-maxg@mellanox.com>
 <f2efe2df-14db-4e15-3807-f81b799cc0ec@intel.com>
 <20200518181035.GM24561@mellanox.com>
 <03238a7d-d3f3-7859-deb9-dd0a04fbe9ed@intel.com>
 <20200519135352.GV24561@mellanox.com>
 <20200519141927.GR188135@unreal>
 <774b4d00-ab2e-6f1a-eaa6-a7afadc3c44d@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774b4d00-ab2e-6f1a-eaa6-a7afadc3c44d@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:208:23d::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 14:30:34 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jb3GI-0006FC-Pz; Tue, 19 May 2020 11:30:30 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d15b59d0-c134-4f5a-98a8-08d7fc013108
X-MS-TrafficTypeDiagnostic: VI1PR05MB4317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB43176CCFD70BE593C3B9C2DDCFB90@VI1PR05MB4317.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaEjyfsyW8RZVdBjAJ7eNbCL2qTGXSOMAimjpVuSVS4pVzbNUwiJ+CfBLrd6G0ar3uOW4yXGUVzdoy7SXw4WoondGpBDSoFKalhkFnzDJpVzYnfa5EDtbZ89Wfsckv8bvxDvI00LLOiPKkhdcvW87jgC0OSefFNM/9Y7NEZvvVs86SPAxtWokX8fotes8xhfhaMA/XI8Kqip7vmJnRq1BC5BsCCwSsXFCB4NV60xm5hPEbk76HP7rksbAI44J39vOyx1AQjjxTaTXwfbUN4bP7daklo7NxGhMJodh1dnM8ZavTMD6p9W9y2Ye3enfF+iSncTy1BhN96/CSYDgBnFcFACB+k3vvActU2ez96x1+UQewuaaWPD6fqM5ZhXL/FIZdSldlNgkblD5ysvzgDD8QDdszBZz3PZMd/PBhLmplEFIdrt9d7ZfxbPUuWkfstStdiw1IBhnledXEjutVzlGkQIM10Cg7jW1lXT4axE/oyX9nm+7M/Dj8bLhCTuIv4k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39830400003)(1076003)(54906003)(9786002)(9746002)(316002)(5660300002)(2616005)(8676002)(33656002)(8936002)(478600001)(186003)(6916009)(26005)(4326008)(2906002)(86362001)(66556008)(66476007)(36756003)(53546011)(66946007)(52116002)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wZAh9ESJctHa43/W0A9Bw2FYYYbfUwKQkMRjhYjWl3pAvChR2E1W9qoLcavWnLXQ/cc1R7bFtGNmcZ8S5taS3kOYsgHmvhy5EUY/G6E/xtCCUWL7Zrt/Af2BT6syGJDLh30F5ZIqL69BAxOQ143lL4F0jtv6MhV2PET2uBxIJc6SkGfoY1+CxG6PCaKdrSIoBMEQ8ACD9MKCafNk2w7HyJ4jraR0Xxr5xVDUoEs08LOgMDKBeQZSwZuMfU82WBhERcHFpkyd4uoc5rk+4PXleQ2pDngRG80TTbVBVmI+nVk0hOMHMV/+tANkguP2n89yUNP3Kkf/0Nl5eS0F9SOlDpdcd0FG7+8QIRmUxpYnzxlvZd/lexPf92+RFpV6OcafZaiPHbHB4NFviC0JaPvQJWW2R5w1/w9spApKl7TVlAovmOtj4RxGnXF5bSToUdaao4fJ22j5TgpZ0pg3zc2w7swQ4aTuTxrZvlt90Ctnx+g=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15b59d0-c134-4f5a-98a8-08d7fc013108
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 14:30:34.5677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0E+m7XUJAt1SaZ44Z3TaGyYr1cbJLTRzQ5O6goJEFMYLSJZBRVoF+Q4FRwXFR1HFfUUPxgKoWaklPIUkWr8/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4317
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 10:26:37AM -0400, Dennis Dalessandro wrote:
> On 5/19/2020 10:19 AM, Leon Romanovsky wrote:
> > On Tue, May 19, 2020 at 10:53:52AM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 19, 2020 at 09:43:14AM -0400, Dennis Dalessandro wrote:
> > > > On 5/18/2020 2:10 PM, Jason Gunthorpe wrote:
> > > > > On Mon, May 18, 2020 at 11:20:04AM -0400, Dennis Dalessandro wrote:
> > > > > > On 5/14/2020 8:02 AM, Max Gurtovoy wrote:
> > > > > > > This series removes the support for FMR mode to register memory. This ancient
> > > > > > > mode is unsafe and not maintained/tested in the last few years. It also doesn't
> > > > > > > have any reasonable advantage over other memory registration methods such as
> > > > > > > FRWR (that is implemented in all the recent RDMA adapters). This series should
> > > > > > > be reviewed and approved by the maintainer of the effected drivers and I
> > > > > > > suggest to test it as well.
> > > > > > > 
> > > > > > > The tests that I made for this series (fio benchmarks and fio verify data):
> > > > > > > 1. iSER initiator on ConnectX-4
> > > > > > > 2. iSER initiator on ConnectX-3
> > > > > > > 3. SRP initiator on ConnectX-4 (loopback to SRP target)
> > > > > > > 4. SRP initiator on ConnectX-3
> > > > > > > 
> > > > > > > Not tested:
> > > > > > > 1. RDS
> > > > > > > 2. mthca
> > > > > > > 3. rdmavt
> > > > > > 
> > > > > > This will effectively kill qib which uses rdmavt. It's gonna have to be a
> > > > > > NAK from me.
> > > > > 
> > > > > Are you objecting the SRP and iSER changes too?
> > > > 
> > > > No, just want to keep basic verbs support at least. NFS already dropped,
> > > > similarly we are ok with dropping it from SRP/iSER as a next step.
> > > 
> > > So you see a major user in RDS for qib?
> > 
> > Didn't we agree to drop it from RDS too?
> > 
> 
> Just basic verbs application support is enough for qib I think. I don't see
> any major use of RDS.

Well, once the in-kernel users of an API are gone that API will be
purged. This is standard kernel policy.

So you can't NAK this series on the grounds you want to keep an API
without users, presumably for out of tree modules...

Jason
