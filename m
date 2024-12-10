Return-Path: <linux-rdma+bounces-6388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E09EB229
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 14:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653EB1887E03
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B551A08A0;
	Tue, 10 Dec 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fda72QNP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41811E515;
	Tue, 10 Dec 2024 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838513; cv=fail; b=pumATHQk8BEGabVT4Dye6lf5kLkF5ED7fiG9Brih+IAVDvMzqPA4ys9tj9f5KdbXMjqD2YJeybuBvXk4uHFfE/7V0W0TWKRSHDLaGGY9RrSPzXhiCrqRmQbTYvBp1ngMAjMhr5CSXdmHNr/nQOftBzpMuaI8lgLxAw/O/AFTzmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838513; c=relaxed/simple;
	bh=RV1gQ6OZxqAcNvoA0YHlLN2lkt+7dZcF+AA38TlCotY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cJtU+gZFMwe6B3kBy08Zkc4DcrRCiZ1E40dVlRcNQeiyCBvMBL5VKfd47Hvc01sqGfHC9VFlReiOnHT3+oS6AxVbXWZyfrwHPql832O9wkfEAuPyml99ewg4xzvrjicsKVQzlg11YZG9CJBF4WreRDUgSLC/tYQJ1Sh7mLm3GqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fda72QNP; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPBZy/qY1I2O5CZbmXGI+9fet0oCjdcnTVH1yw8UZbPwVajROwk+fYoYsUSaev3tpNAihlfPs4VCKN5XrdSjlEdRRzYjMPhRuK8O3Y3YfamlAnZsSOBuvqYCIY8YCqqElmsBCFqUCw8JZzBipxUgiL7y4jRG3yWT/4Rc1OgQsVsLfvZdx+vX/w1dotwYup8rvo7CrOtvNsyQIvAmE+K5YEwVNjgiSQp9PzDrlRgFZauHf1xdS96YKRWovQ/umuEmYymzByeZp/wdsWENGmM06hz+UJ8dVGh25mefkUuSYwpkBXvPXL0PlU+aTaYCAQ356ie3tkB2RpRvgei9Hy8fYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uhoVustdB/9sB8ljf2ajbO8h13E4/YOJrGZSUEnhHQ=;
 b=tuFSmuLzFxjy24V1PjYvQL5O0Waf0rBysofLNnIHZ3yjR4fy3TfHPocap8JDIQ5VSCsC6+oIXm3KioAU9W4CEC4JpHqdOnghtQufnHLNYhTuUAKJdzJYBveORL20zgnTk01oKj9muTfNityNAh6A2R/ybV1FeOLozNUsFkarA9QPQmEhjmy2MLlINnV06I47H3ySK4YNsEqGNQtEODI653cJDe7CQgKspMdOpVQRik5LxPPqE6xyITsmsOFcmWbkAneufRWZ51lGdL9uqwaQQICS0ORH5N9hiQEUpfa+sPYYWiCl0i/M4456Fclebn5tltI+6b6xGk9f6DBvjZNCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uhoVustdB/9sB8ljf2ajbO8h13E4/YOJrGZSUEnhHQ=;
 b=Fda72QNPCW1tTsvNpWWJ3Nwne7BJRjQ802OsCGUlxDlaRqetFmB1Ase60VIloBFRGiVz25z2y1ccg7A23xFbD+0VwEvISux5Mv1HbCRCBz3SXmtDmEZPYxUZCrpAW0A8nJo3Xg7DM+qA6g7GK3JNLbAzIv3DCqoBRAr+BjU0ki0CXl3z6shGduyR+WQ5J5bq5QW2s5KMQxW58rtOMAzMvLopHR3GrpLDwu9bxtSki6jrIWop7vv1kqNBmG/ugGIrEbsIuq38QlIwK7HvlklFiFf/9xttsOKQ5DuP4f7PZRI7lTdzqnDs9EhhSPpAo/Bw0xqVN/f/3zcfIIgHIsMnJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 13:48:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 13:48:28 +0000
Date: Tue, 10 Dec 2024 09:48:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Support mmapping reset state to
 userspace
Message-ID: <20241210134827.GG2347147@nvidia.com>
References: <20241014130731.1650279-1-huangjunxian6@hisilicon.com>
 <20241209190125.GA2367762@nvidia.com>
 <f046d3f8-a1c8-0174-8db9-24467c038557@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f046d3f8-a1c8-0174-8db9-24467c038557@hisilicon.com>
X-ClientProxiedBy: MN2PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:160::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: e34c6f6c-4ec4-4115-e9ee-08dd192153c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vNdV74TSb/K3vcw10RhiuvoWzcRJUHkRYJCO6eLy5n6nLeJ9jV9ntR8S1aJI?=
 =?us-ascii?Q?tHlf6XoT3klynvl7a3uTmsNenjBaM9dc3/7IieKiksXv2AaK5ZfiJ0mEyfOx?=
 =?us-ascii?Q?N+9c+bRpqS9QSDIAgnw1UqTq6bOgGHyRjzkl6CoYfsVUnQqVuUb6vBSaYSgz?=
 =?us-ascii?Q?UxXziOX3SvpauLQaTKXUu9Blq7vUpT1ZmXXY2gnE02qiHA5/57G+qIypioz0?=
 =?us-ascii?Q?rVIca+E61PjMnO8dWgER/+Xc3eGLq5MukRCWC0E+2Lb8+cHO0NxYy3N4T/rD?=
 =?us-ascii?Q?fRL8GV+IxdnmzVW2pLNTk6nGQoTW+17tZ5g/4uXZ1/8lY6Pz2hvUsVnxKgLF?=
 =?us-ascii?Q?kI3dQPjKMv/2ykN5Eyzzy0aibQAfmi1icnZGPAtRBCGx8AlS+WbAy4vZ6Je9?=
 =?us-ascii?Q?X0xjlqFz+RjcSKDnE1+zJvLrY4t1uxvbJVkFAyjMBunH2M7Ja1fhrx6Ey14E?=
 =?us-ascii?Q?rJvB0jPMhY+zjhyF6Qm0Wu36hNRedYyzpOxK88DroHeHSkApNBUs6j2dL9pO?=
 =?us-ascii?Q?T+tOPNdC9E/CW8YenTL21TK+By2sCFH75FD/ulz4A4jHDiAKaTdkoJLlFrZ5?=
 =?us-ascii?Q?SqgK/15WO6lXvBlMWf0Drkk5/q13tVMY9/7uXX/QHLu/R7bRsbd9rj3gZsLn?=
 =?us-ascii?Q?iImq2+em7VCSd3q5EmaCWPc9lu9gaj4rTwcKmHp89TRFcqAPnxKQ+PqHa8DC?=
 =?us-ascii?Q?utg8d6HZ/KOheVq4wLb1EswVXVs3ThMWzSgharzwHHd+Ps+P7LpWUK2qDhdq?=
 =?us-ascii?Q?hkV9i8Y71jKkmjqblseDZiqiC+b1s281vg5MmJXob04yL+xyJUOJZmJjKcc3?=
 =?us-ascii?Q?SrefY7qsuEzcdikkJXC8QgYidnaTlyHXXfeYuhpPVG19RhX0akwv7Fe10tQ4?=
 =?us-ascii?Q?aHjtawce2YuiTHGk489X9vkSMK05i/qIBYuI7KrDxp1+ZUFlHRMHsgPOrGHq?=
 =?us-ascii?Q?buyW1Tera9vpZF2hyTzOPnxB4ciyEsAu31BuK1BHeYWw+JUavec6Zw03BlAP?=
 =?us-ascii?Q?ky119a4WtDtWxG5YIbG3zDNwnSsFiHzDGOnEAjy1p7s5ECN2JgHom+AkLWuF?=
 =?us-ascii?Q?PedMGneUlIeJl1J9o5cERF/ttRZAGH33LWcHLSzuN0IWXzRZbByyK/xa80Op?=
 =?us-ascii?Q?wr2uZHBzd1MsDfzLWOv7VYHr7TlCZeO2vSLlGmZ4+3gL+Cn8/PLOq6fPlQud?=
 =?us-ascii?Q?erpSkhfq/JWKYpqenmPNR+1PeQuU9d4A4rOrXUvGkdm0zDezhbSJ9OCYyFL4?=
 =?us-ascii?Q?KsYFVrXg2oJTg2h22Sq35vMAkEXGJjpZI869OgYX32SFDQVgWCpty108AYOU?=
 =?us-ascii?Q?2Ux1sDpIiFpCd2Qr8K7uWPhSzxx+kkC53eAkXU3lpmRADQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F4HHCI6497oKSyfv0WO/O8mdBnKNlw/TzQ+VMhHQXwM35UoxEfPCzQ3bP7+y?=
 =?us-ascii?Q?shLlNSpbuZJApN742YJrZ+ck45wrHXfOR7Pg4zzCXz/PRTYLdB1p5RH928Gi?=
 =?us-ascii?Q?NBh8vvFljxpgGC+y3c+aTibvRFauGyy1wTy/X2Z/I++nPIde1OFMNzYNpkfy?=
 =?us-ascii?Q?qeqDj73LDuq07wewBI+UkT3k+1pX2kdUiI7fEOmHqSAFkhq+ro79bNCx6hQ5?=
 =?us-ascii?Q?ankHCaM3byhEomZVscrB8tofL2RJy5LBXg1a9Rs/etqFTLgCl2IucM3zfpOg?=
 =?us-ascii?Q?LpttL/ll6asjMwrsUV417BuqGeZwuJtwXnwoO7OL2mSWQvxJkJe83HcvSDig?=
 =?us-ascii?Q?v8t8XXy/Va9dw8ph9AcCLHisa/pNqhCdsF/hmL5AeYUtFmcuaJYVy/cLQXLR?=
 =?us-ascii?Q?QGBWN+6lUB+PKRHPhHkfM2q/KtcJ57zdE9U/Ks2y0KyuZ+3ZkdGX7klZ9iBv?=
 =?us-ascii?Q?Rl4oUcXo8VNHN/dgMWgU01C9a+LTIvxL9l9rv9a2B1v/kUOGFWIz1IuRNywV?=
 =?us-ascii?Q?NPoeroA2qN9C83z8Tpd6w5YTcIOkbBEba7HRgjqFva1hixXDG82I6I6KSmIV?=
 =?us-ascii?Q?Qh9geJxdcWgRnzbNUFnrGR+dXAvsO5sR8CHfY4Dzm3cj8gjIpBD5t7da7j9B?=
 =?us-ascii?Q?r7luAD8K9DxqBsP1McIwF/J6bCvOAirZcyPpkVDXbORyNIYUg94xpT0dbOvR?=
 =?us-ascii?Q?23+Q5hwPyRSgtaQURbf2KT261LwMWrZk1kTwTJnbaSegjaNz91b6ZpFzd55K?=
 =?us-ascii?Q?2SCKLLvzBumHwURibCV7dgH790AKVIxid/zFkcVbQuiaZUi00h+VahN2DjZn?=
 =?us-ascii?Q?H0dKdSTjPCuiRamHpTxCvmsERs+7Hhm11yMGDMLnjsmPlGimYqi9xmLpT1Gr?=
 =?us-ascii?Q?rZbi4bgcK1vLtxFpNUGMOSlY48spsRBdzWfGVTVeKxZTAKKRtZcp8zvZG6wm?=
 =?us-ascii?Q?UH2fr0RVmiOF5JV8jyGd3w+GKl2dxVH/C3+5kWMscNj7DQNSmkukD3a2a5Lu?=
 =?us-ascii?Q?PCSQbobr2v5+03J0qLt6K4yDTmHjjTiyfoC2yzRnNneQ7LKIhPO8Nr8Oi2tA?=
 =?us-ascii?Q?yg7SwM+PR8advab3WfB37P51wHxc37icwrF9J9KwOHBPZh/o7HsmxPRNmGDI?=
 =?us-ascii?Q?pghegpcSzSO8G8EXNhE0QBQYOPV8oaZd8gag/Q7QhS8SC8Pcnq5AAjQOA1As?=
 =?us-ascii?Q?/LhwS61xrOcr4bZiOgoD090lj/vM6kjnKRaHYUboZOWlieuBeDrxTTEZHw5j?=
 =?us-ascii?Q?dUpm2JKeoy6oy87mgdyrgOj5j+4+aUtKF/9RM6Zr0FkPX/tyqVKwaK/IAaQT?=
 =?us-ascii?Q?GeiwoxQWydkJALyJKZr6Z2UOAJL9W9omSyi/MzSir88kNSOIqO4x8aBjqJDe?=
 =?us-ascii?Q?WB0fk3YvK/M+6Nti5kKMBLDzw8SDQsCfWQCygSQLbYaSiUn05Qx5IaEGasks?=
 =?us-ascii?Q?4U9jrEcoUZU10phmlv6skjUYfpUv4BvAV58gVwt3eICNJRPet8a8mGbJMYLQ?=
 =?us-ascii?Q?hFeNtYmkIzgLAvbxbnevjWakFCLjgZPf/RcEd/655/U2P2xt5qwmq0gKuu2n?=
 =?us-ascii?Q?kHoDlZ9GuP+6hKtg0xQDluRM4PLEGEnVxoF2g4KY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34c6f6c-4ec4-4115-e9ee-08dd192153c6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:48:28.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlBPMa7p9Kt/+D4QOhm+apxEj7tGaknskz81uQ7RNmy5EofNLTIyplMy73f6N6xn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118

On Tue, Dec 10, 2024 at 02:24:16PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/12/10 3:01, Jason Gunthorpe wrote:
> > On Mon, Oct 14, 2024 at 09:07:31PM +0800, Junxian Huang wrote:
> >> From: Chengchang Tang <tangchengchang@huawei.com>
> >>
> >> Mmap reset state to notify userspace about HW reset. The mmaped flag
> >> hw_ready will be initiated to a non-zero value. When HW is reset,
> >> the mmap page will be zapped and userspace will get a zero value of
> >> hw_ready.
> > 
> > This needs alot more explanation about *why* does userspace need this
> > information and why is hns unique here.
> > 
> 
> Our HW cannot flush WQEs by itself unless the driver posts a modify-qp-to-err
> mailbox. But when the HW is reset, it'll stop handling mailbox too, so the HW
> becomes unable to produce any more CQEs for the existing WQEs. This will break
> some users' expectation that they should be able to poll CQEs as many as the
> number of the posted WQEs in any cases.

But your reset flow partially disassociates the device, when the
userspace goes back to sleep, or rearms the CQ, it should get a hard
fail and do a full cleanup without relying on flushing.

> We try to notify the reset state to userspace so that we can generate software
> WCs for the existing WQEs in userspace instead of HW in reset state, which is
> what this rdma-core PR does:

That doesn't sound right at all. Device disassociation is a hard fail,
we don't try to elegantly do things like generate completions. The
device is dead, the queues are gone.

Jason

