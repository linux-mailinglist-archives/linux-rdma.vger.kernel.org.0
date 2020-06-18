Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC8D1FFE8A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 01:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFRXU1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 19:20:27 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:55825 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbgFRXUX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jun 2020 19:20:23 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eebf6b40000>; Fri, 19 Jun 2020 07:20:21 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 16:20:21 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 18 Jun 2020 16:20:21 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 23:20:13 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 18 Jun 2020 23:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZo219A19umjy3FjFMDLMG55/lycmvCiLA8nX+51olpFVZ5MFzUU/xVD0fx9y6eBdGIbnDR9n58/vmB7lKj3pX/s5UlG+IXrmZK82tzd1fzF3tq+wFYwatewp75yOvFJ46AYMh4sO99lz9Q2D4slYMDv8KxWKIOG4yCTepepdGOewNJvKFfA7oTbE4y/BSZ8vstM3SZYR5u5dSiwsLsR6K14GtSCwZHMTLRjv8mu3CseuJhwNzo9L4lZLnmGLvai95/cyNK6jIog4j2GHegOhrQj4pA7WFLQyxqL98O5FHLNHKOzlJBPy003UIdA3ysuzjsGzVpP54TWSe18c3me0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBTMiUkp9Nsn+SM4xzrm+RCQG/tiH5PnaM7kMVRM89E=;
 b=Kh1MJWH0bc8kWgII/qKslb8qIqTuU3B54XGWwDiY2VGLcWax0r7s/wq07mLFeHhZ0lFMNJEpbC/A+XLLjjUGDci1B+vlRehpKIKbqpkyVyJmeqzDcEy7Z7yMLMeF6xvbWzkP3poqaaoZE8Fbm/FZ4UrAFq1vHmiK5PJWMHNigp1yl/w+laYQNNvmrT4OnemTZRz9Eu70hCGOmoY001yNtN1DlinrnE2h7CALGLYSKm1oroQ49C5IJfvFbKtF7NbEqQfzwN7yZsO0X6bus7du4M43W2TsuXrV1GL7ntbEkLkyWRcOCrhi6Gzs1LzRjy+gs65iYwZ35dpyJbdICMqksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 23:20:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 23:20:11 +0000
Date:   Thu, 18 Jun 2020 20:20:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 08/11] RDMA: Add support to dump resource
 tracker in RAW format
Message-ID: <20200618232009.GA2487227@mellanox.com>
References: <20200616104006.2425549-1-leon@kernel.org>
 <20200616104006.2425549-9-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200616104006.2425549-9-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0017.namprd15.prod.outlook.com (2603:10b6:208:1b4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 23:20:11 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jm3pJ-00ARFm-M6; Thu, 18 Jun 2020 20:20:09 -0300
X-NVConfidentiality: public
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 500fca56-3e3c-459c-d5b4-08d813de25cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3020:
X-Microsoft-Antispam-PRVS: <DM6PR12MB302056E67A2BA302CAA5BDFEC29B0@DM6PR12MB3020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiWWWhrwZX1Y8MdXZLzVxtFlLvGzFKszvo/Gc9WSXwGtRVbvfPnKPIJpO5D8hULJv9cGiqWL2yerpXp5wmV+E3BPyQ6JQhlOQUiOYllmTXjz1xE04SFIgh2GxCR7Xrb1ak1/FBHrNOQGbgJvkuEPXbgzCoWZhLPuSqOt49f7jmEVxTp9gGPL4kFDt91wZU2l9SM+03/IlFqPXKe3M1jJB5LYgD4pzTxG5IwFP0yVxLwt2CmFS0dugoHBnPEwA2sgjB9uRIFZ/z781OMrnAbEKb0Xu3XMbBaWYE37b28WmSqrgVeBEo3vElmHBB7mSacg4XurDnfYbEOYryo1bmx0Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(136003)(39860400002)(346002)(66476007)(66946007)(86362001)(66556008)(5660300002)(33656002)(4326008)(9746002)(6916009)(9786002)(36756003)(426003)(478600001)(9686003)(2906002)(316002)(1076003)(26005)(186003)(8936002)(54906003)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dUPsIlLIpmrY9EUu4900YI5t8nkM8VGa6ymY48lY1xqpRiZTCMkpkgKCO+f/AvGD4ydkSek3wbuHHj1XYG0L0n0cOzdz/pZ5DegCkM1dwOuNjlBmPTZtG4PB9Ivez9xGOCNYPzyRgP/b/ZZGScdI77qkiDDjjTPUliNuh7ROjJuCNlVNuovi4ZyhFubn4TOLBH2BbeIDke4KbWyXsZBkS38BZG4MJhxKryOO/dM9hDGRb8ho1MVkv4wKYTDAvd3kx2qFrfI5+tYAFGN0PpHBrD+Gqbf4gTqB4THQ7u1LJjy5RGKkhzdJkVDa2WdQm9RfguXee1T+JiA/XxjYq7gd4PcjuAjhMMB/sv8/XvfL1/nQoUI7a1+bu/v/1YdKWQxBQEa7bFiRIwWqu3cm/MCHoEFVJacXq54pWdIUiKs/8J+TWYCsF8TzB1ALEXty4tgPF9Erj6hjKtujfZmWTXrCJ9wXe7pZkpL0/IoT2yJBzHU=
X-MS-Exchange-CrossTenant-Network-Message-Id: 500fca56-3e3c-459c-d5b4-08d813de25cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 23:20:11.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vMCGCKRh6EMYmrJyRi/vQ4/6rE5tID/6uyDP9EC8gN9WAcfV/lVl8ZyMXLvUN1Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592522421; bh=WBTMiUkp9Nsn+SM4xzrm+RCQG/tiH5PnaM7kMVRM89E=;
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
        b=mPAIvKyTZtP229nttxYaA1WSRs0iJYaqa+sqctAhTZs2fP2pk3N90FV0HYufKlEAj
         D/phzNdEv1hQiOPF7u3a14xSGLhabtggWB2x/Uo9iuBnZmQvbv02OUt/kiLK6KpmwW
         MEkTAqt8tXwllgvcUzUQ97+L2nwoQRwTlHmL094uYlq2hDRYkhi25rl7cObYDHz5QX
         3zB7FiFycBwSvw36atdyXANV9nDxZSTo+79uIBaQBuHTMwX34gIbsc7X4J/4n/yz6x
         cgP98zmmxTlxF4kD7TFaW/2JadbPTQPbg8UagkZ9387G96RblWkiul1NOPkpb6AtYj
         duMhMx3rbXlAQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 01:40:03PM +0300, Leon Romanovsky wrote:

> +static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
> +			     struct rdma_restrack_entry *res, uint32_t port,
> +			     bool raw)
> +{
> +	struct ib_qp *qp = container_of(res, struct ib_qp, res);
> +	struct ib_device *dev = qp->device;
> +	int ret;
> +
> +	if (port && port != qp->port)
> +		return -EAGAIN;
> +
> +	/* In create_qp() port is not set yet */
> +	if (qp->port && nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, qp->port))
> +		return -EINVAL;
> +
> +	ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, qp->qp_num);
> +	if (ret)
> +		goto err;
> +
>  	if (!rdma_is_kernel_res(res) &&
>  	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, qp->pd->res.id))
>  		goto err;
>  
> -	if (fill_res_name_pid(msg, res))
> +	ret = fill_res_name_pid(msg, res);
> +	if (ret)
>  		goto err;
>  
> -	if (dev->ops.fill_res_qp_entry)
> -		return dev->ops.fill_res_qp_entry(msg, qp);
> -	return 0;
> +	if (!raw)
> +		return fill_res_qp_entry_query(msg, res, dev, qp);

Are you sure the RAW query should duplicate all the stuff the normal
query does? Shouldn't the raw query return only the raw blob?

The rest seems fine, but this is rather odd?

> @@ -1252,9 +1291,11 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		goto err_get;
>  	}
>  
> -	nlh = nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
> -			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, fe->nldev_cmd),
> -			0, 0);
> +	nlh = nlmsg_put(
> +		msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
> +		RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
> +				 (raw ? fe->nldev_cmd_raw : fe->nldev_cmd)),
> +		0, 0);

Isn't this ternary just RMDA_NL_GET_OP(nlh->nlmsg_type) ?

and I suppose RDMA_NL_GET_TYPE should be named MAKE_TYPE?

Jason
