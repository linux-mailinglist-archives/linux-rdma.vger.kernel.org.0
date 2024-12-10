Return-Path: <linux-rdma+bounces-6395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FB9EB9BC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 20:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E2B166CE9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE578632B;
	Tue, 10 Dec 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JqkMKEph"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A0A94D
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857242; cv=fail; b=OfmBRPvTnZh6vMoI5YfboT/y3gu4DJT5omwu+5RfdwsX9XoBNMQpd6Tld3E9VQag8WL459yhL5UeulusqwOQ2rvP3Wrj+IFP8REm8UYJCBM9UWW08Y+7N5V7evAzCr1BibD5tZs5m/jqQU2PoY0U09C1ZoQXsu9EcfoXg8+ssoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857242; c=relaxed/simple;
	bh=hAJh5jP8Cf3cWmAi2hjYhisSJTQdq/51hyyndej9cyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qvbqP8s78NmHgHjeKX9Moz4yug9J9ZTnn04wpxVj01eR6ToPGpIM40PLemIfsrdZ1SK8F80S3RJI7/2ofaUjrGWraVA9v5rfras35AcgYLVhiEgTm6vTaJpTr7srcOT7UHSRqR5WySokZaNO4JBeSiqErttDg73jLuDgA5wcmdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JqkMKEph; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfhv7KZbCh7XeM+tx72I/ate2461d9rP3cNu3mWZNSbPdLNgXxGTuOyHrHJwRZFOCDjdIx4NlV9aeK3RUfBnMM6Rs73RDJO+8OGdzVPISZL+kEeQiscAqguEA7/ext0yiYUPjoBRHl8NPxHaEmqJEMF0OuwA0y4AGgmmJtAfQ0o0vwCGJPKvlFt9ESQSF87i2Kxph+zoqKyc9ijrwluFCjP2wpysviDt2vdliNMDjMTyOLhZPqlYqCIfiKq9VYxIi2onVrDJnobAFVxM5Opxp5RRiwasbG0nSrt6Tz9si7HRXeHO98bGTCImFjffa0/XOvdQKHsQHnyVFW4um6ISXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUElN2JaU4m6y40Cagb/WmnXdlHgb5fqopaGkJO3I/o=;
 b=eDzki7bXfUJdngJT+21A0v8CnM1ma2iuKDu7Imal/VPqB5/6gND20AmEQhArpkYesjwvRjw9t3o/iVt6r8Cl4c9Vz5zYZamrhg1FYc+jpeNSSgsywLtRE+4Gl1Q/yUwC3d0kYdo2UiFWgroZ7NsF6uPd58Q8R28r/sJBtQLN7P7xP5rUioGzdQaLgh/D6NZmOXZc7xD3FmWk0vHbmNam3asdrzdO7rmP9sMA1mihH5JZg3mCXr9GPmJDl0GTj/7mxxtZD2bQGBeAY2C9DX9zkAjNl9srjdS5PEIzGWMZZvNEJ7ovmI+BcBh0sqz8b7bE6rIsCmXls7bFleUrh5O1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUElN2JaU4m6y40Cagb/WmnXdlHgb5fqopaGkJO3I/o=;
 b=JqkMKEphc60THXdErz+btM3D8hVoDKsS/qPHohgzXnPvQ8RB2cFaxybAjMiZJ8isUsZMuggOsd1pTSpnSaRvaGvq/8xNr0o4KjSgLmgAYjiV4POtd9h5Ww3tiS1rso/6dqxySofr2z+D95qQHnh+IAhURfX0rU+VII4L7LvqsbUDl2/ge9ZiRCjq+7ujK9akkrXrNVT+V8RZtV5LYerzRXOA6N0qvcNXwQrmAQnVVhs85oMpHGlzjjPAZ1K9/EcVuj8ElcF1624Fs5EpYhp3DXrkC4sp8NvWLQyS17/Jh8wbw4PYbfQbHiBmaf9QZsdzU7JKwjJDCS8h10bgT9iFoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 19:00:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 19:00:36 +0000
Date: Tue, 10 Dec 2024 15:00:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next 2/3] IB/mad: Remove unnecessary done list by
 utilizing MAD states
Message-ID: <20241210190034.GK2347147@nvidia.com>
References: <cover.1733233636.git.leonro@nvidia.com>
 <8f746ee2eac86138b1051908b95a21fdff24af6c.1733233636.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f746ee2eac86138b1051908b95a21fdff24af6c.1733233636.git.leonro@nvidia.com>
X-ClientProxiedBy: BN1PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:408:e0::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 416f8ad8-94f5-4259-1344-08dd194cee18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5770CCJpiGPiVE6YzI1+urcozSZxfhqmuopUeByVcb4qAZbCv9F3+OgGR603?=
 =?us-ascii?Q?/0BJutkw4/wG9JKbLs80uGJR3zR7agTMRTp7jxMzzZZzmj6lWlDVn1/MWIDa?=
 =?us-ascii?Q?Hx831YdhJyx4RQWWHSpEmNzcJiZSv0obZNp+HVZKCfpRD13UJwBiqJ6ARojM?=
 =?us-ascii?Q?wEBCoMnFYW4zJcfUUsj5APD++1LmtUMv4pehswhkgTZ5sJwfCi/7F5o2TT+Z?=
 =?us-ascii?Q?vm6qQFmBW7JRwqxDq355Wsw2QL0FN2BZaCyjXYvqPzaClsrOW5V/56ThUDcU?=
 =?us-ascii?Q?z0WIsvA/mYeu0G+Aga7htwUplA0pgdCLzrbHNIW8zZJ4CcvV3Y85VqhMeuz6?=
 =?us-ascii?Q?bstN5OZF2qxo8M39pV8eeTSGWVNZG/oXfHg3YgGniTHH2LYW3GY1aQrjgU/R?=
 =?us-ascii?Q?GZ7FpqHLAorg3AAZpQQReVGij3wAH2a5QcXtlfgeQU52MIUEEuO/kugARkJq?=
 =?us-ascii?Q?93KiJaqaLHI7FsP8/tamRau/Ogi5JsmR4nNTeOVmQjyjvRlW1TLuKyiAcEah?=
 =?us-ascii?Q?bnsDK4qWB995AvxWv0TPsjfbtHau16WQIEBqItELlmZVeVPnsXADGs9/8qOI?=
 =?us-ascii?Q?AOgIgsC9z2utAmTQGCObPxl9lPvuUszepVY/agSP/K5wgGNeRSqZWuuiQEm6?=
 =?us-ascii?Q?6xbSdQgf7nKTYUEunztiBeatoLwfHf8alPeBoSgD7WmlPf+I2Ku8SkF6XcsB?=
 =?us-ascii?Q?m9ZvHDZ+aJSXfTW8sxlul0waG8W95nX+gNlwFSP056fRRaArG5buoU0QVHiE?=
 =?us-ascii?Q?EVjt6mC2iAqceCsSxp9ieF4e5/49VfTFqP02rTNqrXsygsIepYxDkORhlATT?=
 =?us-ascii?Q?1I9QkZ6EoyyjfRzPl01Eu4y9EVPtJnNhUz/8+w8OijVPAliNqwHyam0IUyLL?=
 =?us-ascii?Q?kDypoG4QpIPxnuV5lC5IbeRxqQEyYFrbPXnLN+3jWy95FVNFWue43izxX9FK?=
 =?us-ascii?Q?t0qXfVqEJtqFznW8m+3oSx/E+LdMm6uiwTTwxVnG/zieNEkIe9ngF3+HVCM/?=
 =?us-ascii?Q?EgVGBxp3vvjMgk9grxmvXC4gaLN464RbtWrHUFCf2yg610mUvG3TmTB2Xute?=
 =?us-ascii?Q?6BbMgXIedOpCOoKDzfQrJTJZ5mMTijz7PrO9Eoqsh1QgB46ZtGWKXryr8ZWL?=
 =?us-ascii?Q?AjsdDsy7RD+eVEj8XQwL8Ydf7fFKgHEIlTkf4lF2YqBHWimASYHd5YgHPeAA?=
 =?us-ascii?Q?kc3G2GngCLGYLiQlEnWma2ya2balSkHL5bDTZt61hbJcfuiHuEwk7xf6Laa2?=
 =?us-ascii?Q?cpSFzK2xkOvqrCeDmFHouJ1nYX3etJj3sibo+Bh9n36dc/RnyQTobqafe+Mk?=
 =?us-ascii?Q?3dT+J4SS8JMssA+GCg/A6YQYOeJ5eye7vJcbOH7L6xeg6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUBIclZyZQs8WICljeKd7Kkb7oZkg/Jz8KCd3eVWlU+LA0Wifp1GtO+zRP58?=
 =?us-ascii?Q?9YPASp/SJ2p/3X7h9UTbjfaEZisDimgQ8WGcYUdmZhjNvr8Z0EdouG6Vasoa?=
 =?us-ascii?Q?7/0ElLRXJnk9hrUiCqjufbnQ95VhuOcHxqWU/iz5XduugbHt8ACLrTNi1ZOC?=
 =?us-ascii?Q?j4KuBU9EjQXgGsAJ1AXzH0AriLY6HDHqdmXlhw/Rcc6chknGXr4srr4AxcvE?=
 =?us-ascii?Q?jp7I4mLATgUdtvya2lse5t5Lgu0n+TG/1g0JOCOWp7ElrNwwZE0hlkCMFfXk?=
 =?us-ascii?Q?XbCIt8PXyfgcTEj0JDEt5/AGsF9Gedyu+Z2nzFxkC8vHqubhp5odoEIPKtV3?=
 =?us-ascii?Q?8DXndDM0+pFclraKsGHKnpP2BE1cXjxCIVfV69mfjoaEeLZH8bGqu+NeIjX3?=
 =?us-ascii?Q?p79cSvLe3RQF0l/EKhvjo8ACXwjZSLq/4RDCQLBfFZYtwjK78Of/UA4Zv09z?=
 =?us-ascii?Q?FXmGVR/0NVY65XG4hHpzgIWon3n9v5sbI1xbG4x6DX29r0jYGMhcBI6+LLb3?=
 =?us-ascii?Q?1nxd7ZoGk0Nz3GQ9SmbG5EtRbx8dEHBYrDn6nv5h4gc9TLRP7tFUf2+IFovN?=
 =?us-ascii?Q?VRyCWI7OgSbsqQy4Q/iVWDoK6LT3B+315Nm9r5o7hkKx3eyT0RXqVZozzBKi?=
 =?us-ascii?Q?t5We4twRG3ldkw9ILU+pljJo8Sqay9CSdMol+pKi1c/vOAixAbVwBAr+hPtI?=
 =?us-ascii?Q?fFFiIC3y44mIqjAp6TZcaC8j7dX6RBvHDyFiVDqmfmyaBEOKAOu8HJJtAOQt?=
 =?us-ascii?Q?aPDbfM/k+Sh6c7rGX3/G29mCER+1iRpjF+NxtQw422zUjE1XRJjCtAVBB8aj?=
 =?us-ascii?Q?YzO+wqQM7Sf7hFMXFMVlXZbFpN61fB/Mq6yxGAV9EqUyMt2hXhAn46ljxcxY?=
 =?us-ascii?Q?63aSF2T+ejMnfr0I+33Qe211rQH1nTX8i7pCvOepO9GzDfVI5mNhpaSCAYMj?=
 =?us-ascii?Q?//9BlqO/uxF02ZC6Yk78AzpfnN2AeMb4suXRVw4vuAcpGZbp6eTQ/K9zoUKF?=
 =?us-ascii?Q?OnohjeCWcTx9WDsb03W0TEYF7zOR2Sxus95jyp97mswk4WoutCvwRMUFrQRA?=
 =?us-ascii?Q?UIAPdowmrEwhYoWOWiADD9FWc2ldwTN1Eu1ybG9QPvijYczsnjde8Iiawl6t?=
 =?us-ascii?Q?Wcam07dMyFh3Sgl/AQKblLv9tQu75Wfkdo5loSSb8yDzpIhUYCvD13yUtWLu?=
 =?us-ascii?Q?kF23oGDoVrHLuDxx5MdfjRhwNQ7ZWSNZ/xAYy/xsrUlGwFiXXa5pgJoVQzBS?=
 =?us-ascii?Q?vNxQOaFK0diq/b6hUikQ2R7YIhJENNXVPSeGsl5pYUn3fTwj0gicpVATAKhM?=
 =?us-ascii?Q?gSZdO82sxU7OMOJ0htqikjLZO3c+l3CohLiRlHIheTfuFeUirNlDYJrhyjjq?=
 =?us-ascii?Q?shJUjbNQFPGznX9e8Sk6qwoXdTuLVBDA9pT7X2U5e+I8y7wV3VVsZd2ado92?=
 =?us-ascii?Q?PoJSyEF2AqTrDyS0lDrVtla8RHxLZcgc0MdthNPpLmNiBVBHKES5PRQMCcK7?=
 =?us-ascii?Q?xNvBw/RlOMD6IHibThG1HIDfFSUFklQmNXb3+BRZ61hjQi2ARzrBRyBA6Yh/?=
 =?us-ascii?Q?r/GlI48Zb2pVoxcBGmE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416f8ad8-94f5-4259-1344-08dd194cee18
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 19:00:36.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzfIql/L9zbjJU3CEr1zdRTmU9g0kc0Gw077fr409dH8xYrMPRdIPOIb5EYNe/VH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

On Tue, Dec 03, 2024 at 03:52:22PM +0200, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> Remove the done list, which has become unnecessary with the
> introduction of the `state` parameter.
> 
> Previously, the done list was used to ensure that MADs removed from
> the wait list would still be in some list, preventing failures in
> the call to `list_del` in `ib_mad_complete_send_wr`. 

Yuk, that is a terrible reason for this. list_del_init() would solve
that problem.

> @@ -1772,13 +1771,11 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
>  void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
>  {
>  	mad_send_wr->timeout = 0;
> -	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP) {
> +	list_del(&mad_send_wr->agent_list);

This is doing more than the commit message says, we are now changing
the order for when the mad is in the list, here you are removing it as
soon as it becomes done, or semi-done instead of letting
ib_mad_complete_send_wr() always remove it.

I couldn't find a reason it is not OK, but I think it should be in the
commit message.

>  static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
> @@ -2249,7 +2246,9 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
>  	}
>  
>  	/* Remove send from MAD agent and notify client of completion */
> -	list_del(&mad_send_wr->agent_list);
> +	if (mad_send_wr->state == IB_MAD_STATE_SEND_START)
> +		list_del(&mad_send_wr->agent_list);
> +

This extra if is confusing now.. There are two callers to
ib_mad_complete_send_wr(), the receive path did ib_mark_mad_done()
first so state should be DONE or EARLY_RESP and the list_del was done
already.

The other one is send completion which should have state be SEND_START
*and* we hit an error making the send, then we remove it from the list?

Again I think this needs to go further and stop using ->status as part
of the FSM too.

Trying again, maybe like this:

	spin_lock_irqsave(&mad_agent_priv->lock, flags);
	if (ib_mad_kernel_rmpp_agent(&mad_agent_priv->agent)) {
		ret = ib_process_rmpp_send_wc(mad_send_wr, mad_send_wc);
		if (ret == IB_RMPP_RESULT_CONSUMED)
			goto done;
	} else
		ret = IB_RMPP_RESULT_UNHANDLED;

	if (mad_send_wr->state == IB_MAD_STATE_SEND_START) {
		if (mad_send_wc->status != IB_WC_SUCCESS &&
		    mad_send_wr->timeout) {
			wait_for_response(mad_send_wr);
			goto done;
		    }
		/* Otherwise error posting send */
		list_del(&mad_send_wr->agent_list);
	}

	WARN_ON(mad_send_wr->state != IB_MAD_STATE_EARLY_RESP &&
		mad_send_wr->state != IB_MAD_STATE_DONE);

	mad_send_wr->state = IB_MAD_STATE_DONE;
	mad_send_wr->status = mad_send_wc->status;
	adjust_timeout(mad_agent_priv);
	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);


Though that might require changing cancel_mad too, as in the other
message, I think with the FSM cancel_mad should put the state to DONE
and leave the status alone.

This status fiddling is probably another patch.

Jason

