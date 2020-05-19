Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA61D989F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgESNyA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 09:54:00 -0400
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:14496
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbgESNx7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 09:53:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3G3c6+V6SV35iGejfRk3QWRx0xxH1D93HJ41POCp/46CVzVTdgaNNlwa59YU0D+g6R9wh3aH2OErvAJ9iJxSXY30mLICH72K3+rHEG6+EfHpku0iDJxdJEEI8ejKrfgGiMwRWWwV0muo/0ZpFz7gMfkM+S/FOrqEudUk3OCmPEdPLYUlWOzN4QTvhlZWN3bX0V+HvRib0DlPMvD0tcNvLEAkJ6BteWQY3AZtdoSBm0gkpGGmXMmbTM4ZMvAny5QeT3qWVS/Id4WYM60f+6pYP92wlhFaH3Nhv0cuif1hhXBqsLYhXpdisYNgj9iq7fGJ0KtpkMw8ALHRo5XKa3A9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hj7MaH1CvEWRg2+yym10xvgJUIgJ05+xGxTIDBupgM=;
 b=bUXBJRutRLEL4CuUXJWojKpl1eoPwNtvIgQObKfZYRuvfLUW1SW37DHcUhRxjMLmLSBw6Y1ICypHWO7IdxijVlUqBjnMEUwGYiPxqEGYQDq75zm2kE32HsFE8FIS6daIyi6PTPUl3OnVMI48mxOw67sWTFLnqNvd7Ybzs9ZNtQhPFV8bSmgFM6q8rDcOzdZdWLJtBnwzTfsNea6fGYsCrkMZVQmJ3sxCMBruHK12wGR7rSGgBHYMSPXKXJDFTQ5dmDGKvrsd0RS/dy06NIdBI8TzoPu0ffKVZMaH/JyiQgIJzGwL6cfxng67uh5ruDB1n0sf9qio9Kj+M5MY6oDXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hj7MaH1CvEWRg2+yym10xvgJUIgJ05+xGxTIDBupgM=;
 b=PdwsXAKphl+AAvJBKmD5pIzqbdlmk+/DNUJq9dLpyGcJWfLiXl0jZ+yXywPrzU3uRCnqlIK8w4710EfoVXiRp02xmxEcu0dSF1t+n0RUTmE49lCYEeaRhNBliiLPZDHvK9H6uj/CRYVrbYWbFQ5fN3a6wVpUE6F/52ZYkQSLDpI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4637.eurprd05.prod.outlook.com (2603:10a6:802:5b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 13:53:56 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 13:53:56 +0000
Date:   Tue, 19 May 2020 10:53:52 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        sagi@grimberg.me, israelr@mellanox.com, shlomin@mellanox.com,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
Message-ID: <20200519135352.GV24561@mellanox.com>
References: <20200514120305.189738-1-maxg@mellanox.com>
 <f2efe2df-14db-4e15-3807-f81b799cc0ec@intel.com>
 <20200518181035.GM24561@mellanox.com>
 <03238a7d-d3f3-7859-deb9-dd0a04fbe9ed@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03238a7d-d3f3-7859-deb9-dd0a04fbe9ed@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:208:1b4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Tue, 19 May 2020 13:53:56 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jb2gq-0005EK-EL; Tue, 19 May 2020 10:53:52 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b02234c2-228b-4b66-be94-08d7fbfc12b0
X-MS-TrafficTypeDiagnostic: VI1PR05MB4637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB4637F20FEE7B12AAB5D86BEFCFB90@VI1PR05MB4637.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuJjUYmW8g1gfhgtcYGJ30tzu8aa3cCoKO4HINNzZ4F6Zd2QR4Pm/rPklov7ZwXs5z5LJu/3NXJbPi05n9EIDB5eE9RNwuLuTrw6e7RlKhfQsqFeRkZx5jEWaCj7SODFymeu3vt5TIF5ePlHmoj0Ecw50dD9SaTY0ZqUSgF5doBKJ3XS97k6ZjpJyeulHsgnNyuy/alvguRNCu0DadWZdMtjDmvWpF6Z4TBT1Z7opihJsGuaGBcMRCKcqeQELY7xPPra/qjLLOD7pW4erq6PaOU/bisywyVbeJhLu6PJaySVm6+XjDlIjPLvPYYTbIEGciMmFDvJCbXH+OApkS/UMl1TSTZz4R28HOnCDyF0h/L9y3W1YmiG1a03MH82QGk08IV2KmaesYqIMczaoS6sFGwn72eaAPqAdUCXezg2UfY9qouSVL2CEEtH+zIicgyxBfbJYWTS4VNyBmNXpFD80+qI6dSXH8vEPODR0mEdOzOdefy2AENqyvkz1KojZUuY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(4326008)(2616005)(26005)(186003)(53546011)(1076003)(66556008)(66476007)(66946007)(2906002)(52116002)(54906003)(86362001)(6916009)(8936002)(498600001)(8676002)(9786002)(9746002)(33656002)(5660300002)(36756003)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 301hYR0LZRGtf+0bWV0ETDRc1GD9ZxmDFvqbsYmczOffceLZIkAnYWnAwBjChewNe3ypLIXoVtLyTEwHRnV4513zharPsRD5EMU4Zh0DTbFKxoUMsTeCS9tHtjPgk9LDH5Z+48VxJ67KM9V/tF8VqSqv8S5i3LayHR22FpFxJCdYRbNAjTGwqJFVQqLaSwWTS5Sr6A5/SXtTUKD9BIi9L3Cv38uC20BY/bKzqTyzUWkTRWzGRooc/inIdQs+MlObOxNhVqlNTKV4Hm9eY2u0Lq4PofDjctAZl9QF/lx5fx8SJtDE8cyx2rk1s+i2py40EvQ/2pA+yY95xnN1ks0HnFXWdwKgGLkJuCcoPD2KsAb9iiIYkHrIeZkDZeX977M2nz0CciP3EEWr1GIkdG4YTbLLxtfriA2pqitxA/e1Lmg4iSQ0UoorLrp8CPwNpdAqPVF2/EbUKEv+sdkgPVjzlGw/ussfqkkBA3hzHmwHVhA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02234c2-228b-4b66-be94-08d7fbfc12b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 13:53:56.1816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTsP+IbwfXmdmp3zHfvKa5yh6MAuvpAJkolX7crkzbWj/UZF3HN8SJI5fS9KhKeTJIVwjtxMMcubW4WIts6rQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4637
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 09:43:14AM -0400, Dennis Dalessandro wrote:
> On 5/18/2020 2:10 PM, Jason Gunthorpe wrote:
> > On Mon, May 18, 2020 at 11:20:04AM -0400, Dennis Dalessandro wrote:
> > > On 5/14/2020 8:02 AM, Max Gurtovoy wrote:
> > > > This series removes the support for FMR mode to register memory. This ancient
> > > > mode is unsafe and not maintained/tested in the last few years. It also doesn't
> > > > have any reasonable advantage over other memory registration methods such as
> > > > FRWR (that is implemented in all the recent RDMA adapters). This series should
> > > > be reviewed and approved by the maintainer of the effected drivers and I
> > > > suggest to test it as well.
> > > > 
> > > > The tests that I made for this series (fio benchmarks and fio verify data):
> > > > 1. iSER initiator on ConnectX-4
> > > > 2. iSER initiator on ConnectX-3
> > > > 3. SRP initiator on ConnectX-4 (loopback to SRP target)
> > > > 4. SRP initiator on ConnectX-3
> > > > 
> > > > Not tested:
> > > > 1. RDS
> > > > 2. mthca
> > > > 3. rdmavt
> > > 
> > > This will effectively kill qib which uses rdmavt. It's gonna have to be a
> > > NAK from me.
> > 
> > Are you objecting the SRP and iSER changes too?
> 
> No, just want to keep basic verbs support at least. NFS already dropped,
> similarly we are ok with dropping it from SRP/iSER as a next step.

So you see a major user in RDS for qib?

Jason
