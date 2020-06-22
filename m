Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C020368E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 14:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgFVMQ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 08:16:27 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:5171 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgFVMQ0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jun 2020 08:16:26 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef0a1160001>; Mon, 22 Jun 2020 20:16:22 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 05:16:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 22 Jun 2020 05:16:22 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 12:16:17 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 22 Jun 2020 12:16:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8zz5QXhEObU3E+rlJmlRccJz5CoCg3iUEZEWXMCqBB6piWo86yjuhDZHlElI9uo6JwwgapUx19ZoVY24uRutyvOBRv0S1owe6fkX+xy5U/cDvDGMQA4IPIQIf7DY9mv8eoDxV2g4GxPUxWA7M3adqyGMQXLcJqEMNvqzY4Fe8piR+UrsGOjEPtQ+tbblQiXyxMgXkZUxBT41XxWRJA6jTTnoaQOqbNlhTl78sPxMQEfA8oHNmfomVZT+jB2HHnGxav0NlQipxRHIXCUcD/u5FMNNShfKThbK6JqtmDyYmgX9MVCYPj6auyOBtEpOg7Bzzn/lGajFRKNpm+jcf3QJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76FEFdQ7d7AJUKOeRzxwRugLdXbGR3DCmWi6LfMLDvg=;
 b=RmLViFn07pNf5SjT3xhRTmtB3gmKmyGF+tCRfXN44CbYc5wCMU0a3FCraGzcHDs3UODrti5GCZRQ9hVYFXx6RFz/2/WffBbkkBH3Wt0LWYFYVtwLpNI6B7iPJE2Ba8muj+4TzSeA7d4K7T2XbSnprVXRhd0SAAjU2+tLgimQl6IEibAGh16hQgbPl4WnCjL2rLr281hfkQVLlXSrgI7cJQLXbcTCJBypDOqvmhce+XS/hT5VTmONjLCrClBVo/LqLqV/21FhQMoBdZMWUVll/JJWbEMwAKF34to4RaVZYY5GQUZGtr1kqQneK9l3BBqsxKHYn6s8ddrOmIBlQWKvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 12:16:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.026; Mon, 22 Jun 2020
 12:16:14 +0000
Date:   Mon, 22 Jun 2020 09:16:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 08/11] RDMA: Add support to dump resource
 tracker in RAW format
Message-ID: <20200622121612.GA2831263@mellanox.com>
References: <20200616104006.2425549-1-leon@kernel.org>
 <20200616104006.2425549-9-leon@kernel.org>
 <20200618232009.GA2487227@mellanox.com> <20200621075532.GB6698@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200621075532.GB6698@unreal>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:208:1b4::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 12:16:13 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jnLMy-00BsbM-RF; Mon, 22 Jun 2020 09:16:12 -0300
X-NVConfidentiality: public
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1427809f-d328-48e2-a71d-08d816a60eae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4012:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4012FA13ACE5D52608DAD405C2970@DM6PR12MB4012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfHl2SXTA2g0mhmA1mNBVSzh0nN+u7+PLnHPvDjBbCSH19MtTSyHbKyWtE2inb+GlCVwwEUVX637fcRv996opbYxo4wcFmb2M0sgrbIYANYrRP1v8xDoHf+7DTYFvkj3+lPV9dyVCPYlmlRke/92ur/bGH6EiHtoPtSx2Lc9wBVOI1skOilZxrDhsq12hCAQrtJv+4dzFHcL/2eno5UXfjgpY/BUsUQHyjhDgbZmTxGjDeDQsjj48pEoO6HYZRtCfqifmigbJ5EdpgBDJ/TmlEHzEAi8p4hmp1RfKTU7sELLqDD7/1+pjLwp05NknKioEGQXCcQOFeb2wh1OMf8ZSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(346002)(396003)(136003)(376002)(9686003)(6916009)(66556008)(54906003)(66946007)(66476007)(9786002)(9746002)(316002)(4326008)(8676002)(2906002)(478600001)(426003)(33656002)(1076003)(186003)(8936002)(5660300002)(36756003)(26005)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lLzQTJ72zKxTGbVqOmsO4lN6XYUlfsM8Dcg/Fey2dYycJcci3N2LfaIzy8FgIZiKFi+wGmSBDCiGcwJo6KQShNN/QryUy3SiSBwPgGraLoIdZtmE0P3wzJBi9goDRs3uSbjSDSuv7YXFST/XQ0vhtZ74fcNQpXeu8KzzAPNim5G4V/KvDnp2ANYFSgVAdblzyK15Dy95Knobs6HeCXYb1av6n39UaX5WEo9TjLDxIDKSW+v6InhRnA1D0GIAF9D39moacXLh6PHbQEfr2YI/6fLZFu/rFCxQvR9/3I48YXlmenyblbcp51DV+sTknnlY4Q9qrWMVMUs+bwXCCvF2L9a4hD9ElbKpSsq97Dv5tPsl9qehFX/KwVhkMp2HSAUI3OSjqthsc6gG5Er49Q6KLKnFFcvyceujEcenfStXkdG1ms2KNGvhVv4mps/eWZM9ntpwMuRa3pWmnOAUo/r1s10UXK/w4tx0rEcu2p7evqg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1427809f-d328-48e2-a71d-08d816a60eae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 12:16:14.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DL3nRMbV3ks4jMEUx/pDhjf2lKfw47IcS9Tvz+D+rRaGBPpisZLBVERwnvxD0oa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592828182; bh=76FEFdQ7d7AJUKOeRzxwRugLdXbGR3DCmWi6LfMLDvg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=RAju/Q6+N1Vt8dbaXfp68sg46E2o59FGhRw7uAbmIn7CrF6AoGyE5jt+Q+g8vl99Y
         BYJ6WB1yoVkjT0GXIH5myrtRNDSgiQPZCLfxX0UMmszbsfEOzVTEZgWyacahzdtWMR
         1LRABJrFBiQCwBqV5yeE1a2Kx2A5fSPThicbvGrTdGLTU0lXYPJZntnJOWbqwJDllY
         rS/d0GsYjdxjAf5ycX1RZcfKZ0hlxC/1cDBCpTwEGQrLqAOEPoZXqmWvQCauNfSjMZ
         mBiz1aT0ZfpGNR/iRZQVQQBB+DY67fdjkeD0UfD/qzXebRieEgOLEmpVe2NOp/p8YB
         wp3pOGiYRk8WQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 10:55:32AM +0300, Leon Romanovsky wrote:
> On Thu, Jun 18, 2020 at 08:20:09PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 16, 2020 at 01:40:03PM +0300, Leon Romanovsky wrote:
> >
> > > +static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
> > > +			     struct rdma_restrack_entry *res, uint32_t port,
> > > +			     bool raw)
> > > +{
> > > +	struct ib_qp *qp = container_of(res, struct ib_qp, res);
> > > +	struct ib_device *dev = qp->device;
> > > +	int ret;
> > > +
> > > +	if (port && port != qp->port)
> > > +		return -EAGAIN;
> > > +
> > > +	/* In create_qp() port is not set yet */
> > > +	if (qp->port && nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, qp->port))
> > > +		return -EINVAL;
> > > +
> > > +	ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, qp->qp_num);
> > > +	if (ret)
> > > +		goto err;
> > > +
> > >  	if (!rdma_is_kernel_res(res) &&
> > >  	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, qp->pd->res.id))
> > >  		goto err;
> > >
> > > -	if (fill_res_name_pid(msg, res))
> > > +	ret = fill_res_name_pid(msg, res);
> > > +	if (ret)
> > >  		goto err;
> > >
> > > -	if (dev->ops.fill_res_qp_entry)
> > > -		return dev->ops.fill_res_qp_entry(msg, qp);
> > > -	return 0;
> > > +	if (!raw)
> > > +		return fill_res_qp_entry_query(msg, res, dev, qp);
> >
> > Are you sure the RAW query should duplicate all the stuff the normal
> > query does? Shouldn't the raw query return only the raw blob?
> >
> > The rest seems fine, but this is rather odd?
> 
> RAW duplicates only fields that are not known to FW, like PID, name
> for process identification and port_index, device_index, LQPN for entry
> identification. The only one in question is PDN, but it helps to
> understand relation between PD and QP, so I would like to keep it.

It makes more sense to do the normal query then follow it with a RAW
query, that is more netlink-like, IMHO.

De-normalizing things by returning the same data in multiple places is
usually not good design.

Jason
