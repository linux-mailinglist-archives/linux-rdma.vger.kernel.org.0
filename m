Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE2386E41
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 02:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhERAVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 20:21:52 -0400
Received: from mail-bn1nam07on2089.outbound.protection.outlook.com ([40.107.212.89]:52777
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235539AbhERAVt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 20:21:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn/XKhaIQhRInld4ASw4FNqMaPDneToNLup0v6hogPzBrdrrLqjqLkFgkLXSxrCDDfMLTPlMT4UJhLqtR7RZewR7AUOKm5xgleohiSEc/rG6Y7zETbtfUoL8NrbOzXEO4fgiqY1nRvWWv54kRJxCVnXtIB0huxiBPo0Y17r9wS4LiDk44j52LTI7Yqxe6VrjqUBrm+OOi0d1WVz1uj2xBbUqn0O2wj85UskxKTWsfhLTKc0Qkt0GODgi93+HuukKtfAv/VjOKfAQBU7cigy18W/Uh0kAt5BBo7K2gxAPC8gB0GzfVyy0Qo8SBbdkj5Aff2yEVw70+VdSKuZaIaAeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2xUkVjxwKDVBNWcaomzKdtCl6Uc7eEvRP1orDmS2fY=;
 b=oAh2pC85cUJrpQhzQGEhW6rZFzwihhmneXiZsOSz2CMVYokq1wHX5QHJ0TFHCFEwxhUxF39HQddklN+/89dOrBQ1CM7l6DhLCgcbv9CFWfKZ2V6cwfqFcMmFK4jv7Ah8bJBssndvkaKQ4dhaLvHg6QD/dz72gEpN85VgJWUNS6skVKy9jqmRWL8BYzqwtAY22qq3g9OQANM7MkJvlR2nKM6hqP6favv6830eYYm/p8A2+Ej2rGqdTHwXAL6GCoH6IBC/6PI+uva+BV1KJ4gKC0F+0T7OULEddcCbBFfcD6fVnX7SmUXRxUf1mNgkwn3RfXkvI/WVwmoPrK0O0oj+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2xUkVjxwKDVBNWcaomzKdtCl6Uc7eEvRP1orDmS2fY=;
 b=CQQYR9MdOFf8bsKuIuxDARVZalDApKCPwy7/mApmydPQrqFVuRT+XvhUPzo2be6RjW8cJJMB//NW/6ZekZe2p5aA5FQi7P+025S0cKs8jgON5unwTPhcLRV1+UTfSt50fZTakEmrjjNvUotqEfHuYFN0i9R+UtIugHLyCJZ9XekanV73vFa1IDRFLyrZamfM6p/xuDZKIdzfWs4xzYVUegVxNCyN3wZa2VXbWjXjP+EDfL2/54Ri/du1czA1h/PBK0vB7/Pu9c3Cxf4mH/sPWdcZWZJo4lfrdAroUCYCBn9n3Gw6+bRxzr/L7KhUnaIv7XMFsz000XPTIZuJdoHv4w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 00:20:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 00:20:29 +0000
Date:   Mon, 17 May 2021 21:20:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Message-ID: <20210518002028.GX1002214@nvidia.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <b6045737954e4279939669a1f229c835@intel.com>
 <20210517231045.GV1002214@nvidia.com>
 <641e6b83b8694f859281e74ee887c6b3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641e6b83b8694f859281e74ee887c6b3@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0248.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Tue, 18 May 2021 00:20:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1linTI-00A3CG-FT; Mon, 17 May 2021 21:20:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06857455-9e6b-43a1-4d5a-08d91992be2f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02018AA2AF40190AB4B51BA4C22C9@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSzAcJcweq7X4lD99Il+tfjw/mNwu4sesGN1gOe01Uvrpl+okLS6/bm4Ub4tiGl+PwCVjHjVDZjKHSRQRvIa/OPXxvh9Q9bjcT6u+xH6kB+WujfApBS1l2qTUz6kDTqtFlMQ/iDrTWqifEou1QHM2Y764RbYWHUN4wYr5k5bqaBoYD87vD2Jq3NMt5QZaVY3lLw/3oTVpk4CEB3Pu7vmOcr+W/7MTO5PyLAeT43vDZUEJxW0Eqc0jooUl+yp7BP8e4y3aZrk8SfbyU2D505rci0HTMz8408fLo25nYQ/4yhEqax8OpZf7Eze/KhtmP0L2Js+3NRixjzDS7eIg+LsvUY3ERpeVWj+rYZDb+mZXCSnk7epExC7CM5zhNwbSH3dHLMR+WARZtBfbEZ8+/QaEiy917wZmdbazGcRaTrorUKrxXSj9ruzR3wXywLYPcPgXxSiW4ujAt4tibzPXx2S8QAVWzcW26sNwUh2nc2FhgxVeTW5xhPbWsL4by2Em8NftwypmaKljqmzpJ+opo4uj3a3is9Sqteroy+2i2omc4lg/xmFyQUbJhxWJXbvyUWK+JZxSiLACw95hkZhd2doqwv+SMuV3oMq9k6KX5F9s24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(54906003)(66476007)(66556008)(2616005)(478600001)(36756003)(33656002)(7416002)(2906002)(5660300002)(8676002)(186003)(8936002)(6916009)(4326008)(1076003)(26005)(83380400001)(38100700002)(426003)(9786002)(66946007)(9746002)(316002)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0Vfx7nxycS2slld93v3i5GljJ+st6NI+HsQbS6Y9AQ/E+j1EEOZQsSaq/Ax+?=
 =?us-ascii?Q?qVPvjM7Gva5rUQ+kVGA9Pl+zBAFCZANVPJoZt82H0V6dtruvzuYuPzAqCUmC?=
 =?us-ascii?Q?VbMVCGX/LtpAR7ELaWVhVi4PMIT38vJdz/E+8qT4nOgt4i2T8rV+LDA8ZciP?=
 =?us-ascii?Q?VgBYASTDzcX+bpbm3SHiT1y4KdgQcROpTIL7aeVAmuiY4a5y32SigE2p+cY8?=
 =?us-ascii?Q?NUjTSSfiahoda49dbz5XktmgJV863t0Ioi77fldFjG9jIqQQcjnKm565piyK?=
 =?us-ascii?Q?H2mkx8q2qQQ8PYmPNfj1MQlAXPegfHUcq2iSGv6hJSh1Byr72WKS/JngbM0I?=
 =?us-ascii?Q?WLWD+2Z7MYq468VMaHOO+2fE760MOWPGIvJrahOKoUsgC+KZT/HHL6eRgZX9?=
 =?us-ascii?Q?qrz+2HkMtv71q8Foe7qTmvCZjupFAaOM6czMh0nfUrISkzXukDsw4gYfGvI2?=
 =?us-ascii?Q?UzM/TT6OtoU470kL7dMD3Mc85Eebcl3fbIxTVivzpJlvK0HqAkfKFxFixo6t?=
 =?us-ascii?Q?rMZNAc82snT2ijehXb2hfIK6XmvrTrE8ORH3fM2QwEG/ZFnk9HaSMmY3YFxO?=
 =?us-ascii?Q?eLXyIZZ+LbY+kL/NXfyEOISH4onV1tEjNkw5xrA+32JPmKGJlDYlhlU27Xk7?=
 =?us-ascii?Q?vbxmEXmW45H1RoCSODGprLeljGzOebe9/g+PAkRjY2WI6xkGnkapSlyLRg+R?=
 =?us-ascii?Q?MB+Oo4L4K22Zth70ayPjhJbsfJ5yxojjTsiALnc6UOKolO1chYHRIc8ZerVA?=
 =?us-ascii?Q?PbL/I8v91SxHhO6oTD3ejTM1XiUjX1MEN1YhBu728yrKyZKqjrWTcsb/ULGK?=
 =?us-ascii?Q?51HNDWrADqP5i1EPP9n/e2mRVal8DRb0OeRIrZN2QGOnVl1grJPgJK3yIBuO?=
 =?us-ascii?Q?XtgT+MCjNO4CcfCNX2B1J8gDicHTZbGaYlr1HDEUZEVPD7qeBVDRd4DTbXJk?=
 =?us-ascii?Q?ghhJA2nB2ZmrzEr2MvIzrovJobX2VkM/bcX3eUmpXjcK7LRN5U1G3b1Tc0JO?=
 =?us-ascii?Q?fMasI9YnnHlvvQawfgh8/5kstT7r68Fmc/Ow9RWrtjRgKyw6yNaoudrQ0HLC?=
 =?us-ascii?Q?zqS7PfOlxYVB6Vs0M7afrlEyc0jVQSmwEDdr3RatbL7SRCxN1VeoGBjTm/Lb?=
 =?us-ascii?Q?2j6jbWLHD6Jfw+9CfvHwtRpOXTH+HG0Uuiwa6eGvd5JHoyM4/ncIhJifPb1F?=
 =?us-ascii?Q?XYIy4aRNh+xKDmkNv1WmfJ0Zu9pNd+cOZMJOt9RA1hdXV9iyPGPDZ3GILy0U?=
 =?us-ascii?Q?ZpTDkQY+7r33KLiVPXaRM8uN+XkQW4K7lTCRLwUbcbjsalLO3mlWI+JG2ASQ?=
 =?us-ascii?Q?jkWBR0LSVjI7yBH4takELxU+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06857455-9e6b-43a1-4d5a-08d91992be2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 00:20:29.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLU9a+9aHKinWfFe0hfonCRKua9RFZU2fqtDoA+sHiqTAEmpV3yT1moGr74Ee3+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 18, 2021 at 12:18:13AM +0000, Saleem, Shiraz wrote:

> > What does the sysfs look like? Aren't there duplicated HW stats?
> 
> 
> Yeah it is duplicated. So we are saying for phys_port_cnt = 1, we
> want the stats to show up in only place?

Yes.

Imagine you had a multi port device, and assign the stats
appropriately.

I didn't see anything in the list that made me think "device stat" but
I don't know what several of these do

If you can confirm that these are all port stats I can delete the
device stats in this series.

Jason
