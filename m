Return-Path: <linux-rdma+bounces-2887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 712FB8FCDE4
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBEC1F2309C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863A1AC436;
	Wed,  5 Jun 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FPAl4qIk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12101188CCD;
	Wed,  5 Jun 2024 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589200; cv=fail; b=hsk9yGHjp1nulzJtWOaLT2d6LNu1MdyGpadCh+sQJL+LLT3T4aEJxzSYKu8pFHodtJ0F8y0De8K09HzkmA8MqwWiU/WSAWKIeuEghVy0ZR/vImjh1jLkcJR484xOiJgSk9j5lwg8w1S5cffHRT9T6gKcMfx5kMUjz7WmylihaVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589200; c=relaxed/simple;
	bh=VMLMTtq6Fl3EQHHOtrCx01nEUdtL35Dd+lifSma72L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NanrHIFyq6DQ5zooPyolI9xe0vKyMMNZGs7LSYLgAUGgr+0tFuELqzVZNCVpv/WWow9+ASJNKChq4oI7DdfSofl950/qr18xnDfBq9gS63Y5QahUVl3jRzd5c2enUzU6+oPpzC3FFCmcWmrRL72yRupig0XU4zVnXNTjvtRwyIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FPAl4qIk; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrJn9PLAmpYpRlLgG8bF5UmyOG+sLYC0RgygRWqCr0d/l6/WuwrTpZGOcsW2/4HzAPejAusKisbTb3j7MBRHmC0mlhVvK6clBoqJ+5Wo8vwjtqfnlXqKrK3TSVWgID4Nd+1XpKh9lk6CrZg8v0/Ys8TVvn4ppdjeX2ZD8G0smj+/Jbzsa2GE3XiYA2HSPpJHt64NRX4fSYn+dU0FqFQ6iGQ/e1oGL/w4KWOtTDb8zC4B6QEay4tP9Yb7Ys4Owh1IP6sZle2lt/vOL647e9WY+eJNWdT0tcHLqiES9HRzY4/+b+OT/1++jDbvQuEG1xBEiv+FdiGw5rnBdQMxTqrbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI0tZx3lBAFROE/wZAd4jqF9IN25YfATkowhSufibzo=;
 b=n0PLnKXYUq5LDskq6kkn74gFcVCqiae9JH+YQKoqoHU+tOKlvT+GWNLs+z6wpNxPxByqzLZWI9ttLxljCZT+2k9oFw5+vMF5EoF54Zp+aCjaM4lCRzDtVa1tJ/gQNkPMyBEg2VZiqemGSNgOLipcPKkaohhxj4F9h1QYumM1BfzkoKS0wrtvSvjZJ9L68IstXxUThtCEdZktGOvJzXOtHf3T/mpVs5ujShJtUOhOOt6ZUuEVu0lihVs5QvCzSVsP6vACy46fVYAPrRc1UqHpQBr+4kwole67h4G8wejDmW5Y7FNzmt/jQIPHnJ5ng0pl9ixv27SSaj0dup0MHn7rsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI0tZx3lBAFROE/wZAd4jqF9IN25YfATkowhSufibzo=;
 b=FPAl4qIkWTvWsrdkFg1NBWmqT7bOuuSVcY0JUsQ+S7mnOC1VzIZwK3HwsJzMZeJrogpJn7zFJQFPQnqabLacrK18XH1eB3qw7CjzGcB6ZqS/6uSRVoFxES/8IkQrnzVODLZ7MfxMpDodcTaElDkD6Ywr65Emu3tnO5qTxhvLD+TsQeR9k4+DIC1nnljRQaem3FbH6/TsEqMQYMXxUqcJOjr47cY6j6dCJ9Nm/f/mJT4jSW9FTHSksyyEQImv+JIuEv9j3aqo6nPJEK/uKXXAQ1JmK48/L4v28/E1vDu0E0J2ssArSFAV0KURNpoypZwPOyXHMnUIGq+E8/eJrFgITQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 12:06:35 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 12:06:35 +0000
Date: Wed, 5 Jun 2024 09:06:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240605120634.GS19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240604201103.4b2973c5@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604201103.4b2973c5@kernel.org>
X-ClientProxiedBy: BLAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:36e::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 4927e837-052c-431b-4c2d-08dc8557f204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YKBcJ/iU2pcle5l0Z2iSyUqbdIqlGfkPkhj+RuPu4Wp/oyF+FPFv9NMuOqjS?=
 =?us-ascii?Q?LgIT1V3WxS6nyXQPAldlqNTtCoZTI9rbkZHvTs6E3ofsik4q4Zc+H6iBpl/B?=
 =?us-ascii?Q?FuhamB+JEoc6aOYiOGHOctuB4DZHGmkL+K6uSxuifsxZ1XT0N0BiVBglx09g?=
 =?us-ascii?Q?xwqJRGmNIU2eukIm73O+H5hUR8xCivT2/u175xIUowheUGruH+Q0pidC2Bv8?=
 =?us-ascii?Q?OtpC7vshMdU+1Ys1wZGNpRbw+ud4IYml6V31kBJwnJY/8RUyL3CnTVh+Jm+3?=
 =?us-ascii?Q?8w3Fa3F/unsywaADjBWLsFkl+XjYUWxYHOb14NtfNn7sv0g+WvL4ds0xI6h2?=
 =?us-ascii?Q?KtrN4i2fIcr9YVWDOyfrnuHe08y9M5lFo/umi3XJPhV2P3yWc2IRqF2RLNtP?=
 =?us-ascii?Q?E459FZwxh/L0y91WnCmR/GbITDmMNIQD5sst2VuWCSZA3WfhUWOresiLnnCz?=
 =?us-ascii?Q?fvG8SOg/WNhuHCagLeNOTXIcmyYrbjG9VDGT9CIq7RupbHv7WWKIh/STMD+W?=
 =?us-ascii?Q?QI5WHLpWefXsFQfmpoB3gZAsYrwb2hC8W8IQQAp5mcwh/zvHWr3Xj6z6pCAV?=
 =?us-ascii?Q?OqoliFdjr8z6phkL6EJRurPKIjpHYmT13z3AvocM/BNnxuo0dBBE3aEQ1idI?=
 =?us-ascii?Q?t+wdO63DGBcknhJ6DMbPZrbqjB+P50iVLM2VEIwNIObdLrUhRgz/r70KZ0kG?=
 =?us-ascii?Q?ZgtDvgcwRZFItnngr9qSrLu/ZGrWiRPciS64zYF8WieFaiSWSGfVMs9J6G7q?=
 =?us-ascii?Q?WjbboO34N/ZYAt0dQGJjqtqmCpwR1aMhoPc3AKW5m3Lbyr9gJe56ATb592Hv?=
 =?us-ascii?Q?kK8uGXJpkJI0fQki6vaN2nd+OnKAdLTfwHouZdZ2WLeU3sa2knoCspvB7OS0?=
 =?us-ascii?Q?Yi1jNPzt6zzRSIJs6wiHtnVExtbdIfFaMFMwNX+bkyDot+iZqgkvvPP371JK?=
 =?us-ascii?Q?OiEsAQaAExSlkO9/+TV6n+/egJAJBthqTpoubNDjy+Wp3HdC2dT6QoaCMvTA?=
 =?us-ascii?Q?gBAzCjNNmoSlZlt4nye7R/fPzHX49b4WuLPryIzIT5uziBFkOhMSExz9VYtv?=
 =?us-ascii?Q?krkkH2PD9YyCYuwc/YElk6bP7GMf8jdS/eNKkWm92EESANz54kX7wtXaI17x?=
 =?us-ascii?Q?+2CjOZWJwFonqRhgIIKrDtZ5RKXwn/Zp5L17pzSbi1rab6h1Ai1bLWD9rBJJ?=
 =?us-ascii?Q?xOq114PamMgY1+nJQO7motfyfGrte3z11G/YDNCe1lDYgCy+2TRQ0a+t4B39?=
 =?us-ascii?Q?bFlt3WG56R42my3VUVEY1gviHEHkz9nLh2Iit/ylrePrh0VZoGMzJecafcF+?=
 =?us-ascii?Q?vuxT8kZaEY+c+xvGTcOY47tK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?misxJa7IRsRqHMq2jrmohWLV3NrtaDHp3QisFQMEkg5ytAi8CVOL0Sw6kVo6?=
 =?us-ascii?Q?1C2XOkRFXt3GlIvqWede2xWrOkJo5DDuvhaHvWUo+IoNQzPKWUnfUsn1qyBG?=
 =?us-ascii?Q?o3rZTiPMbyQUeOmd6r9FqoG6U/DjONyKvKUfFij5l6YYJtj3RcttL4Y/qacG?=
 =?us-ascii?Q?6hlwf8kIfezHX1AWVsx7LjMhiPhDtvixq6Td4WW78R4ue7Ov2NxsIsuaFsgw?=
 =?us-ascii?Q?NPpa7vz6XI2hlg5G+rcDwvk1maHTaB7rJbxweTqyegVi414R5Lv85uHr2LdJ?=
 =?us-ascii?Q?AojMJZjlcXoPlJ4RUC6OM08AykifPsTKiMAHrXzJKKpq2TF6whlH+Ia6OmCg?=
 =?us-ascii?Q?oGYJRZUPP89BCtota9wzmvQ3ejx7iB6v1yNQyhmH50vek1BaSzP5j2fCHgXD?=
 =?us-ascii?Q?E5dYUDr8paI/01X0679xtcWrvZ/o0kWyyq6rseHVnMyS445VatiSOIrzwaUZ?=
 =?us-ascii?Q?pT+QE56TE1WjSTIK1VZrpFixJqGOGFVLR8O1E3sMGhBhgyzTqc72UamzEMyt?=
 =?us-ascii?Q?J3BjAUd7zD8qbmAmsem9wTPpXLvZ4yKPfaJ7BlZ25LWD8ZfOKsEH//XkM04h?=
 =?us-ascii?Q?sCUHtXZC1Y1MdfXjaVF993zT0kMzGAuqe2SI9Dvi7dDp/vcHIt/AJNB4BFOg?=
 =?us-ascii?Q?z8GDfh1KKOS5LjzKjFnCebaSbcXUkQTzLOVKF5hi6brJmJAieuYHfjLt1U8K?=
 =?us-ascii?Q?bu+/DuGD3EDod9bzaaeapp+bmgGuFq5dp37tMjT9aupQOZjoBiRLGuzfaCbf?=
 =?us-ascii?Q?thNS9HGrTGqysZz8hKiqgdK/cA6PBLx46kkilxuSVUsQbk6H064l2KZxckog?=
 =?us-ascii?Q?weWSc8oj3RhVbgLXXGdmz5ydCr6zkiXDOmKL6er7AnhBtTdGUtglsdZ1Zwoz?=
 =?us-ascii?Q?ttv40i4H3OyOzeA8LDMzYkTpZfEVRzyoR5efoaoIfLMpKWmuuz3gU6A2hGHp?=
 =?us-ascii?Q?xGtWE1C/5T0sk0d7yoOT2d84edoh+62uar/6nxiiXS988g83x6Hq8YbuQwWN?=
 =?us-ascii?Q?hDiMYKxT89pgmZOzWP+HbLsR7PlMQ8Ew4bEkOg3EH0qi8C8Cl9z3VJn4xgIU?=
 =?us-ascii?Q?WaVhLBFjgE0PNFX0Fc3mje9lwnL39HUSZZiq50uHxB/72uROnBOkQWd5V8ri?=
 =?us-ascii?Q?IuUi5pLOAzM43Rmt1Qdzt6tJCdq8IUWnycumYJJtyaadtHa+VKNpEgJf3j4g?=
 =?us-ascii?Q?K7r+fVUYpl6jyrJf+w64KN/Tibg+4m+fjPBFABJ6HBC7Fs/p2464Vmor6B+U?=
 =?us-ascii?Q?gOkLgpQ+EI7J3/lfXBjG9Nt9H6K7f0lQYaFUwBE7uSF9zLEvy0u3ntiaNDDX?=
 =?us-ascii?Q?CQZcFenZkXhbRBebG0RvN86cX8EmovK09sit6pDWSbk5Ht68KjC1VhOV/8lF?=
 =?us-ascii?Q?FOHTOEobqK/8pJ9JW8wfleETsi8+WLvAMCTwzoUKqlNmKwlIkdQMiwdbtvJ7?=
 =?us-ascii?Q?T1SatY70wtT3G5TOrjCBKU1vyIEWjbRB3mdwKtuK/6EHDL2KPuCTDqCJy4UA?=
 =?us-ascii?Q?Nkv7LFwUWcGEc3AyH7BdBQzpLxPjgdlHyT0iJyVR1FCyPi6n3C/VQi9yQU+B?=
 =?us-ascii?Q?CnHKFGF98UDTtcb0dQRCbwrcKdfcYsm2d0RzxK2K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4927e837-052c-431b-4c2d-08dc8557f204
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 12:06:34.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiv0SktV7wJb+qjUcELmbKugGUkExkntvxP6Q7MvlyOdcFGZ5KjunSMi/Qg7MZ1N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735

On Tue, Jun 04, 2024 at 08:11:03PM -0700, Jakub Kicinski wrote:
> On Mon,  3 Jun 2024 12:53:16 -0300 Jason Gunthorpe wrote:
> >  Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
> 
> Please double check with Broadcom if they are still supportive, 
> in the current form.

They are free to comment.

> Please include lore links to previous postings.

The link to mlx5ctl is already in the cover letter and Saeed linked
from there to enough of the prior stuff.
 
> Please carry my nack on future version. At least as long as
> the write access checks are.. good-faith-based.

I will include the acks and nacks related to the general concept on
the documentation patch 6 along with a links and mention in the PR
when we get there.

Jason

