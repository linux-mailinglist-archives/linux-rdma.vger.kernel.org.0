Return-Path: <linux-rdma+bounces-1875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9359089E015
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1851F24E1C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D813D899;
	Tue,  9 Apr 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="SWQL2TN8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29713D88B
	for <linux-rdma@vger.kernel.org>; Tue,  9 Apr 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679142; cv=fail; b=UJtgI/s6dY0IbZONQllKJdcj3ApZ6WKNelQ8N8ZYRHmR4L5eI+2quDrfUD0HmIcn7m7XKLIGFy3Uged4oXV7DdOFul5ngbEMHd+V7Ty3M263nNorWci/iGtpIFhgcPknh9JS3M/GDshbblmdUnqGINw2xv6B8r4KD3NRdOEq2Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679142; c=relaxed/simple;
	bh=i/VT2psw4W4uELJMog9H4h5H0MHgRuNd5Y+KxkqHRhk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YByKhYvBvNXBPFeAfyaFUb7Gmd0atP+0RUKf2wjh+DIL36WrWO6Gchy9b4VSuKhafaSn+IcMOhxr9fYA2c2NYLN2YbYHSmTqdpQNP2D+uy3iOzIe+yKdK5lCj5/QW2biOg8vwSR6CRfxOxdpca/qdVR66eZH9FQl2K08wCbdeRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=SWQL2TN8; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100]) by mx-outbound14-21.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 09 Apr 2024 16:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo6h2/LpW9HSYrDXGwR+wJnYwFV9uRU6F/F74kmtTtbjWMFtZzb4sZEucif9Z8zMTzNt5DKfA1eKFyAKMl7MV7JEFW9ILET9VeVHycjl06hgxBFg7URKy2e1oj1UpyVwRbc3bFYBQPsLmAIj8PvxVEPWgrDjxzGcVpETylVUrsEkx39rfu2L/IKx2xlO/KN/rKIEdVm19xL31fLpcVrBVm84qJC/0DT9qJEIYNW7KbRHW7uyENXA2vW1IDItUzl1O6A66BkRm454P9m9tyLb41AUpm/kWV+kHGt0CdBWTE93/BjKs3PJrmqpQC9TCxo53HaboMLm0Z/Zg9+j/SXZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBiY667bzsHMUSiS5a1WqP37HwgOlknqKyPyGTrReJg=;
 b=YWbI3M72lNyalML06Ti3D9uODlLWtWvz3P3i0GcC0qXVfc6lZzeRlyRzl6HosBLYfpfqX8DQ+CYo4B2LYu+SAVg65c+yf49ymkGrNyok4NFjFffvNH4lkmiNNea/7gkwcSnrBcBQphc82ENPtUdwvg4AVIAeqqZwfyXh9n88T7BNhuwQtqvGaWhLzsm5FgAArX/kQ38ig8LKsqSZiXim9dDbGFlMFsO6EiBQyEVbLpSdObkxRoq6XNWjOXFjt7+4qV/Yw0SnqRlj/gKmIkwqVRLV69IvPFw63pSQqpdjgx7+tnj9S9cpO5KVL+eWUJxmJjPSmbJ+cMVZw4R2KSGW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBiY667bzsHMUSiS5a1WqP37HwgOlknqKyPyGTrReJg=;
 b=SWQL2TN86uUZTlhMXe07z1g3V9upnQjE/wYV63X8vyFFKimfifZRXyLfARB1CTAgK4Sv+BrpdvgTdxoaFgF6MUoKd00Mt/dgOdJ8ThqjqOr85uS/VSDzZ+0qEw1lp/bKuZ/Lvj8DisvyKqj5izOGj8NYQyZQkbLlA/Ntf13oed4=
Received: from SA1PR19MB5570.namprd19.prod.outlook.com (2603:10b6:806:236::11)
 by SA3PR19MB7816.namprd19.prod.outlook.com (2603:10b6:806:300::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 16:12:02 +0000
Received: from SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2]) by SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2%7]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 16:12:02 +0000
Date: Tue, 9 Apr 2024 18:11:45 +0200
From: Etienne AUJAMES <eaujames@ddn.com>
To: Mark Zhang <markzhang@nvidia.com>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
	Gael.DELBARY@cea.fr, guillaume.courrier@cea.fr,
	Serguei Smirnov <ssmirnov@whamcloud.com>,
	Cyril Bordage <cbordage@whamcloud.com>
Subject: Re: [PATCH rdma-next] IB/cma: Define options to set CM timeouts and
 retries
Message-ID: <ZhVowWwcW91M9a8j@eaujamesDDN>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc18a96-661f-4c60-808f-3a1167a20e1b@nvidia.com>
X-ClientProxiedBy: PAZP264CA0181.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::35) To SA1PR19MB5570.namprd19.prod.outlook.com
 (2603:10b6:806:236::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR19MB5570:EE_|SA3PR19MB7816:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IYNutW8Dwrvg5CntRWyICwOS1IERJtdHWdI3BEFc161wfemSoOk8qyIPQtZouX+eOYOeg4SFXUcnnP4/0OVTvQlR1HlxOHja921x4T4b4GNBSSdqst3AM33z9XbJqoD7FvR123MoyGKyRanuLa1MyEmsmvUVntaGwH7XLlaWrWxFPaq0nLw/oFJgOZPxpXKkW89na0oYQ1zhplF2AAYHFZla4X/XaKrNVLl7q3Gx9gUPpQG3lbrClFaIp5wFOLj2rmFsK/q/+9rOPjPE10k+bP8/RNNPMJGMsP8tns1xqVBxxqLI8nvwy5sQI6NzYYujhHvOaAwptWPBL3RT+dd0BvN6ISFHuZI9+/SZSuwauuxeM8N0mlqjyachWgh9/3NsBeGDbWDFd3l4kwFF2acUoPcWiBBRHPYQnY0E/TOPxNxyCvyRj/hpL7uPpOpFGDwa1PjrA1+mJHYJnqSQNuKLVaCxKkDtFLusKzVMhaio/SadDK2QPo53UINbi43FBqOf9bkOt+P+tKupS3wsozlRFnC3OQ/xs2qPc7QotOGsw/PmQD8CWQQx7/TxjLjC6vV/IegQltN5JyZlJCaxbkX3VsSwY273YXe1Emq06UVBsa8hz065m5Az/+wPIUEcxrJnW0ntG3QcBeTDYfxFuuAQaixv0Q02ZDtDm55s1Z73e60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5570.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ij1G2lsdwpEd68UEIXjeF5lHcKtSZYg4jPBbmEkw5uEybNlMUNjHHrNAP7eC?=
 =?us-ascii?Q?PAvKa4il8WiCLaFxH4cwnRm1T7spnTpeU+l0ysxJnn8+POHzbcB/gZNGZvwZ?=
 =?us-ascii?Q?nTnMsrh1cl22yrgCTQHb6arezpldYdMnSLGiRwBWI4EQAVJYzpZWOPzLfdRz?=
 =?us-ascii?Q?TQLdw9e/Az4WlOY0db7bbr85xQ6WPrhg2lTvUfgAuyO6jSSk6dcZF1DhM+TS?=
 =?us-ascii?Q?Q/eoi7oGvmvVwWBHeAzXeTBeX1+CUYpbh2Y6Zjs/Om9l2OEomDDYTiRnlDA1?=
 =?us-ascii?Q?ncdMAEnzCPYLlX2z8vJPzN81Fl7YOzpR63ITnXk3kdFBCp2E9oalTRnop8d1?=
 =?us-ascii?Q?UYRA15zIbMlLX8hnKwdx/oc13jLPJzSzNeJCtjYOTtG/r+AlE+SLfClk/thY?=
 =?us-ascii?Q?Yj2QIFiEb7rqMZlhmA4sTlc26SO7CaHd6Omc7nrXKVQltOiCHJSPrq/+s8NI?=
 =?us-ascii?Q?tlNzth3BB3iBeSOwwSA8wH3+0CTK0jLqkDeSqjqhcJPBUUCFR6oBsaLhIxD7?=
 =?us-ascii?Q?8eH/pajGg5zDDsoX/tULxO1TGg6IBdvJRcoA71856tnkzR6DSdmdRV6+u7ic?=
 =?us-ascii?Q?7EWXtVA0Oh3/slKrPwFIAlCTNp5jzo242UlUZXKXuWfVYHo31ES3FcV9wuMD?=
 =?us-ascii?Q?rbkcz+NmJoyCvp58b/g5CcfJD6u7eb8zQKOkUa04Dj4qizB2oyqebe5W5AuY?=
 =?us-ascii?Q?Wp62uXK8fIuIIetxQ/XOYOqMnamPtiK1IExtnTVRqwIyIt3kK/OOJSd2j4L5?=
 =?us-ascii?Q?FNZAavxoYRE18TJKfizrphwaDRZdCzXmIYUdQ+vhQP0mOkXL+4PPBAqxQWoB?=
 =?us-ascii?Q?/LFLwAz4NxhkjdXdtyiivBuOceaTDgG3n5jUZs4Srb/1OGNva83qXg1kcK5r?=
 =?us-ascii?Q?TQVvQO6mowSvit1ipv/4OWbzzmsnYh+o8SZ6aKiU1L7t1LkzBXvHORhfgITx?=
 =?us-ascii?Q?5XBnwdmHjKYuIqxTVH15WYR7C2MY64vEATNMd+t/UkdPIz6DPoOr/HS9VGWf?=
 =?us-ascii?Q?xtONpwaVKa9d8+zROFrz5OnGapIkx2mEjp58VMiYfRcz4Jh1OC5IM++RV3SK?=
 =?us-ascii?Q?mG0+AlulbaomIpnacxw8If5VAfZZAyJ1XAxKIYutzrHeY2UWd+c74veMYTn6?=
 =?us-ascii?Q?ELRrX/E85RR2JNlBcymy60MHJTOzS9RNmXOSDUEx7z67izGv+itZa//TZdI1?=
 =?us-ascii?Q?OX77lc0TWV2tVaQpyRZ00fmGsNQ1aAyh11eSQ/3drwdtdd13lDfIJo0VwmwQ?=
 =?us-ascii?Q?3xTeVWCmrlfgyAQj70CBLsDiw0k2e/JnM51UpDg2t5pkd/YjUiDSiyjb7DV8?=
 =?us-ascii?Q?5KwfjvpZpTzpKobm5h2+SsKiBy2t0wMVQaN3BhmF4SUlL8TTBQmJcCfkFxq/?=
 =?us-ascii?Q?qCqbkRSeNKLLdiYe21EQsnm+pVgFCiEJihh2uUJOWYTH0Mfi5FvVovVEkwLP?=
 =?us-ascii?Q?OMc0KCNjCBB6lFwvKuDGssbept6jJykantxViN7aq2s5vxiJvvPkV1JPsAqS?=
 =?us-ascii?Q?t/r9rEI6oqk2fgAocEahowXqrZvoj0F3ew3Qn187Rc3fMDc6IHTP95par1bb?=
 =?us-ascii?Q?yD1NKZFTrR+WFN9OYb4AW4JUkEUHr+bC5UXPWtJX0nW+mf3EDhLLvr4QAnqB?=
 =?us-ascii?Q?AKOJZ7iJxVpXhzrzeih//7JtNiBhEJWfeuTakjDxPQTg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vi2okwurwq0QCoinvl6jEa6KhJgZQlrb6aEf0D2ISWQ01U6G14vzhaQBwV8SpxCueLEfgegx3ALLtC2B0qUwLf1FGQbPRLnL282dMwXBt61/K0FRPwMgxLy03Tgvm/xsXcx/FAku3r1LGqhrTVQZw51MrIL8UqswSIkhayeN/Fg8oRP3q/N2DSn4MR0NUeU7/hQ7a/lWtOisIHIIUNkMUGSOtp9HwSVdCevScDnmYV3f36uWDHQPMQ7jDErKdPnTYjIx1ALkj43sqGGrn1d0qVdm8WcKiSd0B1xT8zmvNDAT+7hYvYGnGAozRwh+XFkO3V8/8e1GG9jmJtyQfw+iTH1j8NmEq1Ls0FnQV0zy58yXbRGsBl5WnH6gkroVedS+gmEr97/kUksOvcBIQASjcIuDnNOArP0MinG3ffUXRwKiA6cu7Qbe46D0ODMFXjn/E9Dazen3Q7faBRLwI00N0gb0NLZPyLPmiQCr9v45W/s5aKZ9NcpEU1Yslzqfzx5FFHcxJhYC33+ocLvF9JciJ48251DlJqGNCtNpcpK5u9DEWmvol5GD7vOKX57HpszXBuUmTQMD5dVpelBRE5jHjVuaYoVfa4a86Vmu9se9U62dyHivBcyu4eE/LVL5Ib3YdnYTOfxSI+GoTBfRLMK3Bg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46d3afa-e6d4-4a20-8888-08dc58afca6c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5570.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 16:12:01.9811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DGgwaNrUsQzE4Ryel68GD4iwUs5bRGdAaZu/KzrkwPnvZqngybTGZEiRGkeFez1LOzybB7faKfkbLezx6nbPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7816
X-BESS-ID: 1712679124-103605-27733-7502-1
X-BESS-VER: 2019.1_20240408.2306
X-BESS-Apparent-Source-IP: 104.47.70.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZGhkZAVgZQ0DDRwtjAwCIt2c
	QkzcLI3DLFNNUgNdnYJNXEyNDELNVcqTYWAHoPPeBBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255448 [from 
	cloudscan21-134.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status:1

Thanks for the review.

On 08/04/24, Mark Zhang wrote:
> On 4/3/2024 3:36 AM, Etienne AUJAMES wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Define new options in 'rdma_set_option' to override default CM retries
> > ("Max CM retries") and timeouts ("Local CM Response Timeout" and "Remote
> > CM Response Timeout").
> > 
> 
> Sometimes user-facting tunable is not preferred but let's see:
> 
> https://lore.kernel.org/linux-rdma/EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com/

Note here that we hit this timeout issue with RoCE on a routed network.
This means that no ARP is sent directly to the remote host and
rdma_resolve_addr() always exit without error.

As mention in the ticket, this is still possible on a flat network.
If a node become unresponsive, the application tries to reconnect to the
node, remote IP is still in the ARP cache, rdma_resolve_addr() exits
without error.

> 
> > These options can be useful for RoCE networks (no SM) to decrease the
> > overall connection timeout with an unreachable node (by default, it can
> > take several minutes).
> > 
> 
> This patch is not only for RoCE, right?

Yes, you are right. But the connection timeout issue is seen only on RoCE
for an unreachable node.

With an Infiniband network, the "Subnet Manager" will return an empty
"path record" and rdma_resolve_route() will return an error before
calling rdma_connect().

So, the purpose of this patch is to mitigate this RoCE connection
timeout issue.

> 
> > Signed-off-by: Etienne AUJAMES <eaujames@ddn.com>
> > ---
> >   drivers/infiniband/core/cma.c      | 92 ++++++++++++++++++++++++++++--
> >   drivers/infiniband/core/cma_priv.h |  4 ++
> >   drivers/infiniband/core/ucma.c     | 14 +++++
> >   include/rdma/rdma_cm.h             |  5 ++
> >   include/uapi/rdma/rdma_user_cm.h   |  4 +-
> >   5 files changed, 113 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 1e2cd7c8716e..cc73b9708862 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -1002,6 +1002,8 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
> >          id_priv->tos_set = false;
> >          id_priv->timeout_set = false;
> >          id_priv->min_rnr_timer_set = false;
> > +       id_priv->max_cm_retries = false;
> > +       id_priv->cm_timeout = false;
> >          id_priv->gid_type = IB_GID_TYPE_IB;
> >          spin_lock_init(&id_priv->lock);
> >          mutex_init(&id_priv->qp_mutex);
> > @@ -2845,6 +2847,80 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
> >   }
> >   EXPORT_SYMBOL(rdma_set_min_rnr_timer);
> > 
> > +/**
> > + * rdma_set_cm_retries() - Set the maximum of CM retries of the QP associated
> > + *                        with a connection identifier.
> 
> This comment (and the one below) seems not accuruate, as it's not for the
> QP. This is different from the rdma_set_ack_timeout().

What do you suggest?

CM parameters are not used when the QP is connected, but to establish the
connection. For me, those parameters are still associated with the
connection.

What about:
/**
 * rdma_set_cm_retries() - Configure CM retries to establish an active
 *			   connection.
 * @id: Connection identifier to connect.

> 
> > + * @id: Communication identifier associated with service type.
> > + * @max_cm_retries: 4-bit value definied as "Max CM Retries" REQ field
> 
> typo: definied -> defined

Ack

> 
> > + *                 (Table 99 "REQ Message Contents" in the IBTA specification).
> > + *
> > + * This function should be called before rdma_connect() on active side.
> > + * The value will determine the maximum number of times the CM should
> > + * resend a connection request or reply (REQ/REP) before giving up (UNREACHABLE
> > + * event).
> > + *
> > + * Return: 0 for success
> > + */
> > +int rdma_set_cm_retries(struct rdma_cm_id *id, u8 max_cm_retries)
> > +{
> > +       struct rdma_id_private *id_priv;
> > +
> > +       /* It is a 4-bit value */
> > +       if (max_cm_retries & 0xf0)
> > +               return -EINVAL;
> > +
> > +       if (WARN_ON(id->qp_type != IB_QPT_RC && id->qp_type != IB_QPT_XRC_TGT))
> > +               return -EINVAL;
> > +
> Maybe we don't need a warning here.
> I think UD also need these 2 parameters, as UD also has Resp. see
> cma_resolve_ib_udp() below.

Yes, this seems right. UD used CM timeout to compute req.timeout_ms and
CM retries for req.max_cm_retries. But unlike RC, those values are not
sent on the wire.

> 
> > +       id_priv = container_of(id, struct rdma_id_private, id);
> > +       mutex_lock(&id_priv->qp_mutex);
> > +       id_priv->max_cm_retries = max_cm_retries;
> > +       id_priv->max_cm_retries_set = true;
> > +       mutex_unlock(&id_priv->qp_mutex);
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(rdma_set_cm_retries);
> > +
> > +/**
> > + * rdma_set_cm_timeout() - Set the CM timeouts of the QP associated with a
> > + *                        connection identifier.
> > + * @id: Communication identifier associated with service type.
> > + * @cm_timeout: 5-bit value, expressed as 4.096 * 2^(timeout) usec.
> > + *             This value should be superior than 0.
> > + *
> > + * This function should be called before rdma_connect() on active side.
> > + * The value will affect the "Remote CM Response Timeout" and the
> > + * "Local CM Response Timeout" timeouts to respond to a connection request (REQ)
> > + * and to wait for connection reply (REP) ack on the remote node.
> > + *
> > + * Round-trip timeouts for a REQ and REP requests:
> > + * REQ_timeout_ms = remote_cm_response_timeout_ms + 2* PacketLifeTime_ms
> > + * REP_timeout_ms = local_cm_response_timeout_ms
> > + *
> > + * Return: 0 for success
> > + */
> > +int rdma_set_cm_timeout(struct rdma_cm_id *id, u8 cm_timeout)
> > +{
> > +       struct rdma_id_private *id_priv;
> > +
> > +       /* It is a 5-bit value */
> > +       if (!cm_timeout || (cm_timeout & 0xe0))
> > +               return -EINVAL;
> > +
> > +       if (WARN_ON(id->qp_type != IB_QPT_RC && id->qp_type != IB_QPT_XRC_TGT))
> > +               return -EINVAL;
> 
> likewise

Ack

> > +
> > +       id_priv = container_of(id, struct rdma_id_private, id);
> > +       mutex_lock(&id_priv->qp_mutex);
> > +       id_priv->cm_timeout = cm_timeout;
> > +       id_priv->cm_timeout_set = true;
> > +       mutex_unlock(&id_priv->qp_mutex);
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(rdma_set_cm_timeout);
> > +
> >   static int route_set_path_rec_inbound(struct cma_work *work,
> >                                        struct sa_path_rec *path_rec)
> >   {
> > @@ -4295,8 +4371,11 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
> >          req.path = id_priv->id.route.path_rec;
> >          req.sgid_attr = id_priv->id.route.addr.dev_addr.sgid_attr;
> >          req.service_id = rdma_get_service_id(&id_priv->id, cma_dst_addr(id_priv));
> > -       req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
> > -       req.max_cm_retries = CMA_MAX_CM_RETRIES;
> > +       req.timeout_ms = id_priv->cm_timeout_set ?
> > +               id_priv->cm_timeout : CMA_CM_RESPONSE_TIMEOUT;
> > +       req.timeout_ms = 1 << (req.timeout_ms - 8);
> 
> So req.timeout_ms must be greater than 8? Maybe we need to check in
> rdma_set_cm_timeout().

Yes. For RC the active connection timeout is given by:

static inline int cm_convert_to_ms(int iba_time)
{
        /* approximate conversion to ms from 4.096us x 2^iba_time */
        return 1 << max(iba_time - 8, 0);
}

int ib_send_cm_req(struct ib_cm_id *cm_id,
....
        cm_id_priv->timeout_ms = cm_convert_to_ms(
                                    param->primary_path->packet_life_time) * 2 +
                                 cm_convert_to_ms(                              
                                    param->remote_cm_response_timeout);

So, we can check the timeout value in rdma_set_cm_timeout() or modify cma_resolve_ib_udp() to match cm_convert_to_ms() implementation:

 -       req.timeout_ms = 1 << (req.timeout_ms - 8);
 +       req.timeout_ms = 1 << max(req.timeout_ms - 8, 0);

Etienne

