Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFC53975BC
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 16:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhFAOs1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 10:48:27 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:14817
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233797AbhFAOs1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Jun 2021 10:48:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fieZLOd35lGienPYWFKTp2VFt1ABIJwozj6BZtwlw0T6RRwleHt8jJ0T3yvlXcX/Vvgy83APiX4EwcSS8iPXIUteuZHbG8DhdO5ZQ8eY4PgKbvNoPSGpUA4JSwAt40K3N+e2BllmNQCMEUvUAZWV+hJRexbHhlqc3LpJ/fqf2XS5wrCjE8lMLhS5BdZBwfnKC/SmaNBmxrJ/+Qo48OgDSFgNOA32BM0FTWEU3aSBSqhus7joiqezerj/TIq0UERV5dl6hVE8nimDhEsKffoSjx2jHteiR01FSdJKHRzhRq1bBFfhcnZg0U8+vMT9TuJpCiXLGMrONzo/TPiXhb75lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teSx7CmMZxpx4jXnhDM1jkIv4KLqTPY1H/Iy3wo7d5U=;
 b=dJk6UhPFtt+j0nvU0NxBQvxKNs40960q+ku80Tg8PokMpxeV4q8Qzz+J9BvGJto4g9tg/LThgMWFUD/XOpBdJJKGfB8dKlPeoIUNv8hFa3No7Cs2u7Vd+ZpWsVUjpI+hlkvG1RWY6ptePPRVGMLpuMVaZltXQFWgNZ7hpM34fcaADWF1qpNA3TVyDxenzh9197dkk+tbd/tPVE1/UERU/pjVxK+Bttb+eE5Qqvn536/cuNQf0KkQqUBIBawOcthXk0LHY5ETTHJ8sBTyuSwUKKNfrce4QZpvRsl4NU4AAiFNw8Gq1GMpyxITqndoJNtA5k6SSvDS/5Sv1AJtMUJoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teSx7CmMZxpx4jXnhDM1jkIv4KLqTPY1H/Iy3wo7d5U=;
 b=E85Tf2ec0GMqWoFungzW0B/wA2UpGAHE66+mUx4zNJRGAl1FcH0UlZQFF01pBfbw/SOTVh9m4VUdLBzlzLQh2mt/W9oBGGNGIKd2pfsf9ud5C2+pLn90eu+elmZgO+PJBGddryVAA9PtZiIY7f43bsFroanZhFM99GAUi3aAvk62llhWYON28hTbmaDmNslTd9FEd6ksicBykTrryX4qClUPjz0o4g9fo2ahW65CK8KKZwuv6gnfwxhpAxZBMkN8dboqxbiVYSCcGEPtcBcUyDzaJvJ38Mu7iulQFN1KJM0uY4e3uuiRlMu3Aqs/KwLbCjv88Utgw8orWIsjKptioA==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 14:46:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 14:46:45 +0000
Date:   Tue, 1 Jun 2021 11:46:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next V3 1/3] RDMA/bnxt_re: Enable global atomic ops
 if platform supports
Message-ID: <20210601144643.GA4168406@nvidia.com>
References: <20210526153629.872796-1-devesh.sharma@broadcom.com>
 <20210526153629.872796-2-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526153629.872796-2-devesh.sharma@broadcom.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:208:51::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0088.namprd02.prod.outlook.com (2603:10b6:208:51::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend Transport; Tue, 1 Jun 2021 14:46:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lo5fH-00HUPG-OG; Tue, 01 Jun 2021 11:46:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f0b661-4bd3-4580-6c22-08d9250c1394
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111AC445CFF90B75385C027C23E9@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hkAqyY9y7tpI9hMoQe0gp1Ia40ApK+tAgF3tL0sCh1PKgZUy7QVn9BpDksYQDvDcb+Z1GORlDte9zPPKiIN3TwQu8Q+ny1pJhyCRTZVjEUY2d3g/U8fcr4AXc2QZUOjgbVxjHSi3b5cIzPMpXKwLmZMbwaJoibwPQc6CK4tKreCL+JEHnEDPcgkIU0wrZCSXPvCbwiYjbS8R+Vn/yUOEV484HsAF8OI+MoXepcXdoTta/DqoPZ1wX1QzwqYjBdRg9ZFz5lPP4wOx81M9E1UFV7W8borH+dSfmZFdx0eWQjAvaV/3NCj3cW3JOxfydxd0pxjn5AO5HTnKIYyYV/hwtUec8ANtaM1uXAhiDHIXmT+pGfx1WR5Ow7E4xCBw55N3UqaGBwvi6lathvW5QDXM97+guIx0vxHsgsEWDjzx4ume5ZQaULRpYShHwJFcUroSfz0+w8/nOfjIcLOlzfDCvzbt7H8wkFMP6EbX+f3/g8pRyXS++CnCtCK9JpBUBpPhUzGOhDg5aqCbv0TkAtpfEUk0Z54lABAwPRjGnJsZHokywdKrZpGcS/MmMk0gqGg1M4VG093da2q4tDLHy/4zz5EGHjFHj/mF2DnWh5PTSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(38100700002)(316002)(4326008)(33656002)(9786002)(8936002)(426003)(9746002)(4744005)(26005)(36756003)(66556008)(66946007)(66476007)(5660300002)(6916009)(8676002)(2906002)(83380400001)(1076003)(186003)(86362001)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3fH78au6zqur+3l5xkPB7NEup+kANGK8y20c6KmF7JEYbPMSc8Cev/HbdqQ3?=
 =?us-ascii?Q?4rPp2ZODpWMuuvrPlZmYzgUoBGds4NfrJe8splRMsFflHS/pdKhZLjkh7G69?=
 =?us-ascii?Q?MNUR7stMD0XlPf1wUJAVChs3pEPvxLCZ7ZDtiOG3LdHIEgcHNaJPwKBGldcO?=
 =?us-ascii?Q?UctSeCVw0HeJzBhbqjt3hCVfSK0Tn1UlrafANh2D02Phfha0axWjnWBqm0aE?=
 =?us-ascii?Q?sqN1CsSenIPGaX6O/aTgxI/gy0Dk+qZPpXjNFuWh0v/e3b6tsm88HIwO5f+1?=
 =?us-ascii?Q?yl/gvb5PAqLEIVCVGFNe+m60g7zaMFX8/gUAVc+XjdIP/Ab799UqjXLnkxf/?=
 =?us-ascii?Q?NiDY0dx3T3Z72uNpYnbkaXX4UNpv7xe7yIADte9jyvwe0qOdypPGtLS/AM7P?=
 =?us-ascii?Q?AxkEJ4Yz2V/wOp6A/j5jVeAclMCqNjjbQ6WHcJpWUhlEla8RqR17qY92o1k7?=
 =?us-ascii?Q?ZB9yNLV9sPXYU3bI4FcN7nA3peBlGJu8a8pOOOwTnJuLDmDeuCKeFP9mWksb?=
 =?us-ascii?Q?45X4GcLEe41OIyMfm8XPM/4qEiiDjdNCcGvet1Rnf0aJLoOKTCwl77hOG83D?=
 =?us-ascii?Q?1d7xjiCIle0i2BsyxohrtH42Le/ArZdYu6B/PyAlrBlRKFHqe/8Ts5YizSM2?=
 =?us-ascii?Q?hFhS69vdpNpsmmQZBuW91rt7Nu/iMcyWPPjDqvvOj7TuXQ3X7qWElAMGHlch?=
 =?us-ascii?Q?VfsY+TXi+lZ6WXSYeGxgGORO5kLKaHdrEWHzXIPEqNzUj8qVENfrGSUKWmOX?=
 =?us-ascii?Q?SGEGx5eZYippncnrg2Cuoz7b8QtIZZWawIYR4RBA7Jk33b8LCxDtz+/VtjE8?=
 =?us-ascii?Q?45oqWWlgAz+E1/h/Q9h8ybTQMwN+8cNuI0UysIFRbyOGOt1t3zbTzReRbFDB?=
 =?us-ascii?Q?/mhctKndSCp0HkkotzRAmQDIyvJPtUC5QQk9gzcIZFjD7JDSyhj10TzE2GBD?=
 =?us-ascii?Q?NI5c6wGyJvo867XDNz5WSrWFoRlgXETjVJoesX+ASD3SrdOGqdcGFR+N4Url?=
 =?us-ascii?Q?kWxAQST4Nmor0RBAC5pdvNm88HNd25kTKNpYYtWv8BZIzfxVMtn3H1tBt5XQ?=
 =?us-ascii?Q?dSk+eHMzN6joXt59LRMZNDIMesBUCCO74UorFqZsRgDcpKG2bDVu3dJUtAww?=
 =?us-ascii?Q?zaMYG/T7NWqH1TxSbPsH+tOyVVLE+82JZE8fdMF4f8utjYwWeblL/84eAgj9?=
 =?us-ascii?Q?P3CB7qUUsEPYr+A4Y7/ivf7fZ1HLDILduNwmbIlIPTZDaoyjLr0wczFChaed?=
 =?us-ascii?Q?bbNXCUwjgEIF67pvO2KvOKEOwp+b4x8eyEQXNS1XZfEWE3hK3wmJIotzYHW7?=
 =?us-ascii?Q?3iAv5At3aJFuMIgFEmn99pOP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f0b661-4bd3-4580-6c22-08d9250c1394
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 14:46:45.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0J8oMIKPYA+CAhIu6jTPO2vSB5DMl4e4GhLwlo3ls/6qXLlp4pSaTmjatJel/YbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 09:06:27PM +0530, Devesh Sharma wrote:
> +bool bnxt_qplib_determine_atomics(struct pci_dev *dev)
> +{
> +	u16 ctl2;
> +
> +	if(pci_enable_atomic_ops_to_root(dev, PCI_EXP_DEVCAP2_ATOMIC_COMP32) &&
> +	   pci_enable_atomic_ops_to_root(dev, PCI_EXP_DEVCAP2_ATOMIC_COMP64))
> +		return true; /* Failure */
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &ctl2);
> +	if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> +		return 0; /* Success */
> +	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> +				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
> +	return 0; /* Success */
> +}

true on failure, 0 on success and the error code is thrown away??
Please return -ENOTSUPP or something on error

Jason
