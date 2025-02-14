Return-Path: <linux-rdma+bounces-7761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8B2A35349
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 01:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7158016C194
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 00:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B88472;
	Fri, 14 Feb 2025 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qNNmOA06"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A62753FD;
	Fri, 14 Feb 2025 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494541; cv=fail; b=cL4jK+3C5o5SnFzKtVviKudscEgSD83wTv0Txp08UkbFpiPQXX65SuXlWP0/yzBPXqOd0zzVPWd8buaeGLiU3MBcNuxaCC5asjpiQV916Aplalnbsg791CYd0BJjg7X1gBF9hweHAP82B4oWDsWlIAAa1gtbjA/wt/GaMLw971o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494541; c=relaxed/simple;
	bh=y6L9hpx6YbsziAIkveM8ZuSJRAvGzJ79LySpcLRc2EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bPkwvcNy32nQ8mVy6+vev05vRgsfgLMy6VaMI3ZIj8XB1Vg3rnWBi3f3DZXCX3DfPhf5xfMoi1V91PUynNiGYJSLkcYuEYbe2HzpiujpoQ/2WHQFujZ6ieRAPT4QYLajVH78+vJ6Sqcorwf/x+lWFykjtpsnChNpyhfcQscnJ00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qNNmOA06; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFxblCMobnoeoQHC1n5wzuIYKRWvn81Ovk9pZAo/ku2bSXBxufcAQS+Rv2ltq9e0wRB9mWOBV9czmkPWKa4Cb5q6AqPhHivayTJwI0D8ygUs9cdiv6O5Z+N3sW93nrP968mjfz9Ym7AeQtoX0ngwZasKjhxJdK4r20ec16E0m2PPztBi6sUebAAQZX0wzv3JweBnYCqNksSZkho12MbBOAyJkKAB0knt+fP+w6B/AXsvocfoQqjOWNCpjyMP052NxBd7/eXnOO1yY5pUZOKxVhJXhZaEgk8bkarfbQd5PPldqKv132XoClksZpUrBJhNeW/OX/XoNoXD5IKuC+ovFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmlTw9AFPGTGVFD7oDaQNoYVDDgATd9e31R7fnzXAX0=;
 b=rFr7z+9SUj26xiWc6bdXJ5SUhzVIOmg+lbMfj5wL0Zp9lhjDECCps1dOlKEHZlW4IutjjQKB4rerJunuMXs3dO2X6SygnaDiS1B5Z+sDALOvVC5JUkK0GLiEgssdz3i7O1SHcH88bk1kFkS1OcOzRTlevC61/NC6eDG2zufzRK1tRwQCYJgaKZ1AgRJBytFaWRnV7tlLQTyseqxeC2xgn3gaPC0GsAJPhGf2W0ErtQaRmQCTzw7mzTfswBwK3jDiYn9gFpx06LsimAjB1JHjA9d3yAo2RVWQc1ZHz8/JXDL/GKBml0rgibF84VHODcR5z2xCVFWM0D6dPDZvLhm7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmlTw9AFPGTGVFD7oDaQNoYVDDgATd9e31R7fnzXAX0=;
 b=qNNmOA06o2eXuL+ktwdJw6zjryBqlaSi9hh0BfwNhpR0fjYyp8WsMJIl+wJHvCA7EZOKSHRjueJOpO9DIbekr+oaPiAwHiEVFFNcMNspRMSdKPRFD2SM+Zkhe3aKgZxHdZVrM8bw7N8iykI5yM0wHj9eknMQFKyxr/z2/VEbgSIejK/MMFEAAlSpA+ZMgonYD9E8yjl61ULdPr+N8WImNQFSRD5GHWeqq6G6/YAxVu485l0o7qI6MusvXYREdRFgonRIMxX5kFgBZgtFxj3uXnSXTTlkMZcLI3kMFh3ld2CylbDNnqCvwfmMZ+gJHC7GXJdB7Z/yQedzyM83qjuKyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 00:55:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 00:55:21 +0000
Date: Thu, 13 Feb 2025 20:55:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
	dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
	dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
	hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
	kuba@kernel.org, lbloch@nvidia.com, leonro@nvidia.com,
	saeedm@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	brett.creeley@amd.com
Subject: Re: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
Message-ID: <20250214005520.GE3886819@nvidia.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-4-shannon.nelson@amd.com>
 <20250212122215.000001a0@huawei.com>
 <3d9b8966-8ad6-43ee-a745-073a5c82554b@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d9b8966-8ad6-43ee-a745-073a5c82554b@amd.com>
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b4e2fd-a66b-4b30-0a75-08dd4c924203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?66p4w5s3/drz8pmRvhanYVkCDTRtOnkeWneDVRJrBtHbvbk9ZzYSeYtKaGyk?=
 =?us-ascii?Q?8eNLH06V5GJHXktokF6xS6fT2/NLsQIYZLjkxakmzz4PZUavGW9EY3OQS/4c?=
 =?us-ascii?Q?L7NlDExprpuXOLXJWzx6/78QPPKGZWAEyvbsvHmMSq1I3D4ENBaQCQRp2Duy?=
 =?us-ascii?Q?1qBaXHm5J7GUUl5IYuMqNl2VeeK34uCeXJ7rFS2NS62MGzO9BavODhwRZvCP?=
 =?us-ascii?Q?siS9jfrb3ZfTOAyfmk1zcwlJz5gDYJHSX0dwxcbHZyXBrKaEoMzlBhQM7zFS?=
 =?us-ascii?Q?DGxsAr0oF60rzOIG6lLCj6t+fkucpKsxf5x/c22aO/knhSQZvuJUQVxCNLuQ?=
 =?us-ascii?Q?gf1zQT8S5nuCSIxPNDdw5OTAniDbmfeeXDWK0Det0611YzQbWauCcniCh371?=
 =?us-ascii?Q?QP5XONcQP1T+MnNt8xQKS3K0xL4I+mu4xFNNQuGNuLsyrudPzuCW6qvpC3aF?=
 =?us-ascii?Q?whdEaxS3VbehH3CV5PMwnLe60etBH+p6F5ViwjCO8BimlEdLfTvLrDKj9EB6?=
 =?us-ascii?Q?Geu043RmwpVCh5wjd6qqkL1SQc8CqR16uQx2qO7BtPbySuTa0wKRdUttbl3x?=
 =?us-ascii?Q?i92+GwlaCC6B+9uSShdaRW9t2A74OsaSh/mL4JIFsWSWEClgSiW20ebpbU1L?=
 =?us-ascii?Q?6QD9VVwlsDw9M+cTGFmDsTAUp4mO95kEqB2WFxV9H038/oFjmO/2A9cM5Pik?=
 =?us-ascii?Q?m68vpNRnHKUHTIZ0kGzRpUoeoEbnEhUA6mlsjtFzP7W6WqP2Wa+qx3JY3vgt?=
 =?us-ascii?Q?kI8gSgzeeY3uiRCJyQ1S0lA/54WzCKkkL8CPTTI9dqWZMDbl43DKBsPAGZF9?=
 =?us-ascii?Q?dC11Hxqw8w82BzwbYWxYNSnkn6D8sLhtTvhR8DHiXtX2aS94+khd76lXbhVQ?=
 =?us-ascii?Q?/gOvYndVmc6YITaSJnxURyq+qPb+vfafx/QS9XSFDfADa2fj4Wl+8PLbz0hT?=
 =?us-ascii?Q?1rburf1cpo5VIMccEe4WhpHgwY+VyCjOG/ODoUUYALrRNg7ah3bB/tE2sGNn?=
 =?us-ascii?Q?4h7Ax/G9xxiS6CYih4BL+CKJB1zilbHl8VPuQ2SJ1CvRYmCAfuMWt7ZYzqUX?=
 =?us-ascii?Q?fOvXfoop9RnwVttxa64bTHs27PxrPvbtDfK4vd/q8uZRo5evpGvyjh+OkpOc?=
 =?us-ascii?Q?hq6+J8ndLm48y4KqH0gTwXPpXbcTm/xieD0pt4RjavO6K6+ZLE4eX4HuWTHO?=
 =?us-ascii?Q?jxiN0btUIr/REKR9q/vXHsIfL1PB3CpNNiZEP0EaQhXfPMpLRNwzXZZ2dgyX?=
 =?us-ascii?Q?NmYO7p6uwAekAQ3nYYcD8jXx7MKk+biKfVXz1kLN+hiFD/mV9fD9H/jXe449?=
 =?us-ascii?Q?0TRvkLFWLZmH6mcf95lEqRSO3b3ROQa/o/MFQ9zbS6hLGYOOaZopZTNnmLeJ?=
 =?us-ascii?Q?SsPy+57t4RUPrQIFA4vLYPfcd3B5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LEMO9C2ERyZFfkHEGyANL7hRJ9P+ezccULf+fJAo73RfQfkZs2RLY//DzgoO?=
 =?us-ascii?Q?SZWeKweD3v1E8bYBklN8b4jZhwBRoGFBAHhtdlhwa5GJty0DUlGEB0YgZybS?=
 =?us-ascii?Q?apmjl26qzndqWAjbSh9NQMnxBHDMF1pw6PK1DQCxoCO6iIc8VtyvT20srjmq?=
 =?us-ascii?Q?6mS+OuHALly1Fgt+gtQmIK2zNf4TMSY/ZoifKEMAIKXcoMl0SJ3shodFC+7A?=
 =?us-ascii?Q?iUz4PVn8e9a7oYtIavKovgSulotYFgK/ns2J9ZkdYHTAhG5DDOdA+VOCNdaD?=
 =?us-ascii?Q?lHFdshlh9duR4mupGx+ncmX2dD+GI8ltjAFxAwEq8sHatX34nbusQYwyme9n?=
 =?us-ascii?Q?2Elgme8tyCQnlx4CsAx1Pl9St6csI+OtuJ/xhSWDUyhlSwy7uqbw8y/QIxlI?=
 =?us-ascii?Q?ssCLhLCdOvRKS4B9CNt3WRaGb33udHyHTxUiXmTrVO4Q0M880KJNfARP9MW6?=
 =?us-ascii?Q?py+6SPEYa8qv2NyuN4fOaOuGWuCEgVxWYFfmuByy0e/QJxls5Wn5a/zDTIsv?=
 =?us-ascii?Q?YfqIyEKRlrU/VU5XffzmbLbFcR9lpkd/j8fFWA0fnzugwvOHJZYhxTgJcLfs?=
 =?us-ascii?Q?Bsdtla6CWjCcM/ncnnoN6pO0zwQzQPr6XWwKCT0pFlUD8L9XMj4U30readk5?=
 =?us-ascii?Q?I2KZqCxXoPRVzqjeAW5NU7RVSokxZNzkRP9tPzJGZgoXp9GoNZ36xV+xuf6i?=
 =?us-ascii?Q?N3JszdxjUxFKNo0AMUB7T+XBDL4JKVQ6ndmU8erzKu4ZEnTtShyzhf2TC9kW?=
 =?us-ascii?Q?xW6dClX2V4duscCkae1W/9HqwCwZTQMk8HhCLthGJBoBv2eo0mOnQY6Du2f/?=
 =?us-ascii?Q?46CJ7Av7l6j4vcVg58Ltsp93hf2M+uPCs0fwWsRmgmCxI/ZIaE7lSGa0/1IT?=
 =?us-ascii?Q?xo4IuX00dCdbPgip1eQWmsNf+4r41QKu9iljVQbYfI1y+uFNJiGgkjuZuZOM?=
 =?us-ascii?Q?jCjdWTf/nNBTTGRViofgUncPyEz7RKfhnMAVb8C0uJ/658If4NAqTLuDdPu1?=
 =?us-ascii?Q?8VubyNHQRTwwJbyF9mGTADAWP9WLHN1yz/jsJgEAMUUL3zb9u11tSV8gKl/g?=
 =?us-ascii?Q?f5EYNuBENvWOqSFjsVq+OKRUTrZT6UnH12RlMBl6GH9u8pvHbgSlVKBoYFpL?=
 =?us-ascii?Q?6P59Cgq25G1zpXgbiIFf0ekMgqMomesBgaKdfB7XzZDa6s6ZBXgHmyooHLj3?=
 =?us-ascii?Q?VxAQSbgs7NMjG9eYw2V4QbyOj6RI2m7VwY+9XBKTJ5kgfpKAzDvFPfzCzvcX?=
 =?us-ascii?Q?dTmgLJCwLuK3Hk2BcN+CIzUke/a9mKJRCDalVCT3UsXooNobqS88AOc++uVi?=
 =?us-ascii?Q?LvqRH84sHphrWHpKigO6YLCCGsPbOuYSDWMFDVrgpC6MEqHAXrDOihE3we0/?=
 =?us-ascii?Q?5+oqr0/IZo9ISw/049UkGHIvbQKSAe6oyr4m6sbNH0jPwOtpgy66GLA8OYyY?=
 =?us-ascii?Q?9NYlt/8aiNEYoOl+ym9PAdfIgINLI4Iyjf/Sopiqgpxcob24zfAGy5P4IBWM?=
 =?us-ascii?Q?yNHk+yhPfFKdNFCGvQevTLgIC/qliBthDVPPp5WZUzP6WGeLmhJe24qya1RI?=
 =?us-ascii?Q?AvqMKJQm1NsC2RhHA9cvZARsmUJvJAMkVueoN9y7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b4e2fd-a66b-4b30-0a75-08dd4c924203
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:55:21.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuuBkLvFATD2g25thRfjwVHhK2+m7iaBF8vgxuqWZ2s8WyTa7W40vzPtpt1LiO5i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

On Thu, Feb 13, 2025 at 03:06:14PM -0800, Nelson, Shannon wrote:

> > > +/**
> > > + * struct pds_fwctl_cmd - Firmware control command structure
> > > + * @opcode: Opcode
> > > + * @rsvd:   Word boundary padding
> > > + * @ep:     Endpoint identifier.
> > > + * @op:     Operation identifier.
> > > + */
> > > +struct pds_fwctl_cmd {
> > > +     u8     opcode;
> > > +     u8     rsvd[3];
> > > +     __le32 ep;
> > > +     __le32 op;
> > > +} __packed;
> > None of these actually need to be packed given explicit padding to
> > natural alignment of all fields.  Arguably it does no harm though
> > so up to you.
> 
> Old belt-and-suspenders habits...

In that case it is worth knowing that __packed also changes the
assumed alignment of the struct. You can access a __packed struct at
any byte.

On x86 this is mostly meaningless, but on other arches it can effect
code generation as the compiler will have to assume that, say, a 64
bit load is not naturally aligned and emit a more expensive sequence
to load it.

Which is why you occasionally see things like:
  __attribute__ ((packed,aligned(8)));

Which says that there is no padding inside the struct, but also that
the compiler can assume a guaranteed starting alignment for the
memory.

Jason

