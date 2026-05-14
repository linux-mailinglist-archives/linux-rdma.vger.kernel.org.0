Return-Path: <linux-rdma+bounces-20707-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLctIK/4BWqcdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20707-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:30:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD8544B50
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92C4E30450BE
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3A337BBD;
	Thu, 14 May 2026 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="GX5jVWYr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022115.outbound.protection.outlook.com [40.107.200.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576830648A;
	Thu, 14 May 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776188; cv=fail; b=NalwjuXaWYc310QdF/9KMqzODmo+Zqtkkq/mnFNhAodkA9W5WMZwAh4MlTcHJnLeI66uxiCpULzUEjyzdN1pNS7KSSvlmfUILRCSO2QIXsLpSgXZtJzZ+soZcwvYDCBH24vzoN0YlU/KXDtQV90hOfQE3I5wJKi2ZbcXzGV6V3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776188; c=relaxed/simple;
	bh=HdoZhj4IegGUh8gn6URvr9bJBbNFs2zOxLzueQf72LI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K3iQu/imRWHTxShYaW+b2hoz2IE7MlJaXxhbaozN0nrjwvBWLg+IX0gJfr47UTPYqvP63V6TQ/HbxeMiuK0iXBzjmKKXfvrKnMpiC3CGMEwoBEPecLr8xyz7V6dzzVJ6PTHJlShMeOe8rau4p63kiXGk9I7gMdgrNmQ2XMfEZNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=GX5jVWYr; arc=fail smtp.client-ip=40.107.200.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6iOpY/hgOyqiVxZ1SuGFHcHNXg4wAMncgiA1aRwkBhQUoG9Bh6sl5iMQujbLCuGdMlnPwUJo4QVsw11HGucyNByhafrwR5DvfgiAkld/6R8JH8McEcdaAEhDAaDMXxrD11pKuocZINkhZfBVUkkf8JRxdWZrcQeXsVN9bzTwTRzDwK2SijZh4atXLL3TEn/c+0WlTlCEP5VZKLOrLAkI7CtqnHnnwe4Cz6HsPY8vHLQ92bqZWU0MPH0FG5nzrSaxH4kk/FdYOlY+e7kdVfrEDb58xhWt4G6rmxBOs6Svy416gUweURYdxVboydrY2it0U+gy73an74xc+xv3i7ENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO75b0QevPsjqAI9M3CYuO9FjIWAOUhaIF6Yt98hGKU=;
 b=RQyxGykK1vCYOS2JdhoGckLRkqzjWNijj2uKN/7JU5oKSmQRvD8wU+YtezPUD5t5S+eBFgYqrunysjnB19O1kw/9xX/93RUSIu+npbRsqhcdAr4rPTmsMBRJLjyvvhbFsqIJLVJkwWgY7RSYaxaxYe+gEoKiP6yM3vqY74J1sY0OeqjPnu0CCfqFzt8v4+vn4Wum+xyWY3623adbH9LS4dZBUNOI5dmTXMvxI0auVTmF4R3+E7PzZpcREfFbrKdUo46JLc9iq6PTkHE5uQPfgMnDHY1e6JEZgqK8mmXPb4dM4jEP0AtZlnHRwERZ7ooNJm9kGffAMF8P/ANC9x7axQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO75b0QevPsjqAI9M3CYuO9FjIWAOUhaIF6Yt98hGKU=;
 b=GX5jVWYrn12suyCpeD7+GMOhzARL7CBjDav0t5dnpZZkWY8ujr0c3+cEJZ0F17xpYgZDDx5ka6VE0t6Lw6hC/XoYUtMLn7tzpgKTRODeMvMLdF+44zbBmO5P2XG56LKZ+WZh/i4MYc95YStd/2+OOa8lOmZXZhmKX++6hRw9g+8gWV7odu/z6iajoPo+iEMj81wEhuu1i+cvrHWrnkdySYc24zvou3/rj7zbdx5JYg2EqZRUXyAv1UnuXQQa5/8QuLvl4bbgYm7ap8ttJgQrtEUzipfED5kuZnnlOs+J9ommK/I5EZpiTqcWLUuNklMRUKyz7JcTMzfrqOfkCAnZpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 SA0PR01MB6361.prod.exchangelabs.com (2603:10b6:806:e3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.17; Thu, 14 May 2026 16:29:43 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 16:29:43 +0000
Message-ID: <88ecd8d4-f3b4-4bdf-905f-a54c84ad8bce@cornelisnetworks.com>
Date: Thu, 14 May 2026 12:29:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Export pci_parent_bus_reset() for drivers to
 use
To: Leon Romanovsky <leon@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2605050042390.46195@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605050051390.46195@angie.orcam.me.uk>
 <20260512090006.GQ15586@unreal>
 <alpine.DEB.2.21.2605121104560.46195@angie.orcam.me.uk>
 <20260514153927.GQ15586@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260514153927.GQ15586@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::8) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|SA0PR01MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 002004c5-a85d-46ee-13d6-08deb1d60134
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gR5F/eIMXDgvdo+0DVjhXCB+Uy6wjr3N1Rdvz86EULbj2U4DJXy/EOsWr7U51LEYcd4ZAEk4ZVno8Oyqp48QwBjKVKzsi2ihS5d2JRdrKdLN3NdIKRp55PbTaY4arV1luEHYYBqzcvQQcM7/fIQbXOugUqcsx6QSdzyYjr/XkD7TLOL/fruQnHxuVIYWPHjI7GTq7pFXyYNqt9/cFQIJFv+6VXpXCdPSJpsj+GBd52E83BSn4AAAv+qHYfMhWMQRqntD+tYkBMzg7bBlvHJktZiGqNEjtVvznmPHYpl4Uq5+FLu5Z2WGs7BH7ns0VCqAMmWRXuu9U805bCZnrj2623psbrK0S6lX4pQGEDY+unIfCUC4V1rfHrB8esgFsHye4BRuRPrpFeztlEQzPKBhjnCmR4EKg/O6ez46I4mvB04aDXSnAp2X0sRSWrhSzX2dhVFtodXW4StvEqGChNUHV+WCjvwd1fuXU2S1d7xd2QcZ+TGNny674zNmgSQFfa879Cih53psZJ4iA/nBEswm9nQdoVUSiEV3Bhd3k5YHDzzIl2n9bmfQsGgOWHbdj9G3VSAJ1ZGVqXdo0EXWvpDwsyglD3e68tvnail+bpQGmGR0Y0Mi0sGpbkOiHzKCzqh5iGl4DAiVQ476XZCC8OmVi0HSsFPaAvaQHSHCGO5GqarO3YEJ2qhpuWy2GmKLw20lOsnnPet8E9FmIC0Pf7F59w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlFYR0thOGc4ekt3ekM0RWlUSE5KQjBlb2dMQ0RpQ2IxZmUxR1JoWm9pQ2cv?=
 =?utf-8?B?VXpOTU45L29lSEZyZW50REdIZ0Q5Z0ZCc1VrUmd1aHpOcTdXRWJhNGowQ1Rs?=
 =?utf-8?B?ZERxaVgza0E0bWZwNEVyc1lPSld4VGErNzEzWHMxMGxhcURaZk14eGhvbnhT?=
 =?utf-8?B?eExFRkRKdTJQTlFEcDlVa2l0WjZXbVZXc2xsamVCZWVpMFhVWFI2MjF4bmxo?=
 =?utf-8?B?eUtGaEZIMzlnRlpxOGFiYWhKVklPNGQvVlBqUkNBZlZQTFNSRmhLTVR4dWtz?=
 =?utf-8?B?ZWVLMnB0MlIySjIyV0ErQ0p3SWRaK1pRcEUwL2RFYjdTdXY5L3dDQkpPWmJz?=
 =?utf-8?B?dGhpODFKRWlvVE1EYmRnNThtbjc0OWVEMnZOaG1nd2RtWWRudTFNZ2JmWk8v?=
 =?utf-8?B?MjF3azV6L3Zzd3dxeGc3OXFpUnE1UitlcFJsQ0JlbnUrcWVEUGg4WlRlVkN6?=
 =?utf-8?B?Nkd2eHRtNU1Wb2RXNllwbE83L09pZUd0S0ZUQStIenc2WkU3cUY5UFlBeUFw?=
 =?utf-8?B?ZllhSjl1UzJsSnhQWVJDR3hmcnNQSS9IU1NtTjRYbEx6NVBiS0h3NGdPRWhu?=
 =?utf-8?B?eVBXTGZFaVlhU2FUWjFPL0FyTzVUeEdlWFB3RDZsZFRoeU1BWVpmNmZaRzk2?=
 =?utf-8?B?YkY3VmNtTmdxUHRhN0k5Q2U5L2NuNTFLRS9EaXlhZUhvOXROeTl1RHVnUFRR?=
 =?utf-8?B?TWthVThyNzhZczd5cVRLN1oveE9VK1lqaEpQNWZIbE1rTXR4cld2WlZHZ3Ix?=
 =?utf-8?B?Mno3Q015ZE1QVEhZdHdZek5VYVB6aVRUSzYrRWthZGxKYnA1S2tjYnhqNEw0?=
 =?utf-8?B?ZGVzRGJSc1JQRU1ZZFRCRVpwLy9ncHFyVXE1czRWOXNMejlEOTEyWDc3MGZS?=
 =?utf-8?B?N3dWTjMxQm1Mb09VZzNFUENFbzl4czJYRFl3RFFkUGpERllLM0d1Z2hrU3lW?=
 =?utf-8?B?ZmozcmxTQWlFNFl5cEV2SWdCSWVMMVhONDJEdW9jc0d2YW41YkFkcUZJQVQz?=
 =?utf-8?B?aWNyc1lKOFdYZTN1dHl5RzJQbnVhUnNUWEdHMGtoa3NYd0VQZlJqdVVKUUxP?=
 =?utf-8?B?M1orb0I1cjZqL3ZuVjRTUzdWVGxzeElLOUY0cHI3Z2JENUgwWW04UXA0SS9Q?=
 =?utf-8?B?SG1sbHpPbUtuRlgvYnNscDRiOElLR2NCbTdBZ2pmVThBZmlnZzdHVUNsNVUz?=
 =?utf-8?B?TEk5UjlBS1JwbmI2S3Q4OFU1NkhITjd4OUp4NTdNZ053bzZyQ1JGdFpLd0t0?=
 =?utf-8?B?ZnA1U0hxU0t5M1VXZzFjNGVQV1Zld3RrLy9HK3ZBY05kZkdMUkJmQnk4YXJ2?=
 =?utf-8?B?SWd1cGFwL3dnRzJlN0RHMUVDSkdjNDF1ZnpYM1hJZ0FxMFN0RmF4Y01xVVo0?=
 =?utf-8?B?aWhtdjBBSDZjaHZsalJKd0hmOXdKVERQSlY4cXpaS2prWm1zRVRISG0zcVcr?=
 =?utf-8?B?YUkxY1JuaWdaVE5nYW5VblVYMlhjUEJFeUxPY1hSVXNpa290MTBZSlNDZlRn?=
 =?utf-8?B?Ni9ud3FtUG5QOUhFN0hhcWd2Y1pOL1locWxsQmZqWWhqVmlGSFNQa1FtN3A5?=
 =?utf-8?B?d0NPeXV1UjJmZllKaXZOMzZTZXRFeWR5TTlKOWlQZkpTOWxaUkdZUzg4WDRC?=
 =?utf-8?B?NVlDTTVXaHVvaWZlUUpXRFdEUWZVSVlIY2tuZnkzUWVxTFlTVkhyNHRVbUNJ?=
 =?utf-8?B?b1hiMWRMY1JYVnJ1RE5jZkRaNDJ1d1A0Q1RIL1VQRjNPb0htQzJpempjdmd5?=
 =?utf-8?B?STBNVlE4cHZRS0ErZS9POXlqdWJBYVVBSTBqRFV3MnowU2l0enhlWU01QUs1?=
 =?utf-8?B?aUsxTTA3TFNpbnZzZnNzT1BKNzljSVlSeHFENlZmdUx2cm1QbjlxcTZiSS9U?=
 =?utf-8?B?Tk9pMkQwY1NZZm1reUcydE5EZ3QyUWN5STFVaFNkcEtRS0hYWkFZMEJNdndz?=
 =?utf-8?B?QmJmOG9PRW1Ud1pEc2ZNQWN0ODRJTHk5UWRIMFVqWmFCaG05Yk9sNE9TOHEx?=
 =?utf-8?B?QWpQWGlQaWMwRjNOam5CZUpCYVZZaXFrUysvc01QUzEyOFB3eDd2TDBtNkNr?=
 =?utf-8?B?aFJoY0VPdmZJalZsU1ZlUWR5ckhpVjlGTEZyQ3hKQWRrbWY3ZVBYWlVjTWtE?=
 =?utf-8?B?c2RndjcxS2E3cnZvekltY2s2a0kyYVYyVFFYWUd0a0tJUkZKd2lQVkdhNUJx?=
 =?utf-8?B?TmdodkkvSDBlUjlhV09vWGFHSnJtOVU2RFJ1NVBUV1FTa1BxNjI0R3FLUDlv?=
 =?utf-8?B?L2ttUGw0dVhybnZzZFZmNU5ROXQ5aDErK29zaW9lZkUvZ3o0WnJPWlJRazdo?=
 =?utf-8?B?Q2ZPdSs3b3FwMW1KVmtocFpQT3JGdG05Z1FHSzdzeW9LOWRoSkZIeDkvNEIy?=
 =?utf-8?Q?jHhs5B5RoxHrySNjN85kEBQE1MxPZNLQrpB9U?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002004c5-a85d-46ee-13d6-08deb1d60134
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 16:29:43.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoZ+XvF60UTc1S2au/jq3l5pRSZmZTl7XKx3Qf3g9HnlRdemQLlVDrT2qtfIps1/An6jhrsjDHFDl799fdPLW/XnajE/3PeYrQ6eCZZizt7k5fGiKi7tX3M+E2DnXOUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6361
X-Rspamd-Queue-Id: 13CD8544B50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20707-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cornelisnetworks.com:mid,cornelisnetworks.com:dkim]
X-Rspamd-Action: no action

On 5/14/26 11:39 AM, Leon Romanovsky wrote:
> On Tue, May 12, 2026 at 11:17:29AM +0100, Maciej W. Rozycki wrote:
>> On Tue, 12 May 2026, Leon Romanovsky wrote:
>>
>>>> Export pci_parent_bus_reset() so that drivers do not duplicate it.
>>>> Document the interface.
>> [...]
>>>
>>> I wouldn't recommend doing this solely for hfi1. The driver is likely to be
>>> removed or significantly changed soon.
>>>
>>> https://lore.kernel.org/linux-rdma/177516078937.637585.1447184858924347033.stgit@awdrv-04.cornelisnetworks.com/
>>
>>   Thank you for the pointer.  FWIW as per the cover letter I have no own
>> interest in the driver and offered this cleanup as a general code quality
>> improvement.
>>
>>   Dennis, please clarify your position, and if you'd rather this change
>> wasn't made, then I'll drop the patches from my local verification setup
>> and won't offer them again.
> 
> Let me put on my RDMA maintainer hat.
> 
> Since hfi1 is the only user of this newly exported symbol,
> and it resides within RDMA, please drop this patch.

I would agree there.

-Denny


