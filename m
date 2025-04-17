Return-Path: <linux-rdma+bounces-9521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47433A91E1D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206BD17A711
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A51F145B3F;
	Thu, 17 Apr 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUe2iaPN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498CE2DFA56;
	Thu, 17 Apr 2025 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896723; cv=fail; b=JMI4zwLw2/esdOyJA7CN2R83XQqEQtGV2mUjNf+q5OgaEBGSjIA2yNhvi4lME/Fs17jP/b15AFZv9jx6lJ+GDm4otu2Ait9ndmHymalPZHWrZwZPEd2GIHg+L9Jsj58Pp01YnxS8Ci4DFMX6xUiCjwJz7k/gma/8Ennbf9ZaxvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896723; c=relaxed/simple;
	bh=sftNqQBbWXo0t0EYF24gEYf6pocdVDjlEAuzEjjUIbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gLoHrIPFtO612vUAzc851hzjfguGM9sXHXJWNY/6//8NBk+maaqiB4Th7No2uC4bQNGYVDAAYiu++mlgVD3OpX/jbSy4k57Rm4U99mKA+4GgxcAElE1RfoTAZRg/pTWtQK7MHN9+pzGsp4nylElZeCwUEa4cYP8a0LfYfByKUHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUe2iaPN; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbpiGs/T3Oj3D72hVon3EaU46VnEkZk3VqEoE2xdxtuuipGc1AR5b/CSUEBwQMPLaq8m4zuAwhJ0rGKVKH8fjvisfBJOrAppS3klpOgxDrTAvrayLNy1spZGfY1l3Oao/0C+PFJuT+TGnlrNHAjP2gikVKy0/ez7b0NycNXSkv8J/PkoYdag5RosV2rxfng1TsJnXkLS6y+NrdUFnakrJwV+tphD/rI+fScehTozYBNcDmVoT5BDeW3T4Gn5KybNankpOELk39VYo/Qg3joiItyCKSm8uuntQr7lP6qsPjRDdFB20+BJ0NSVPc6Dir1FARkIx4C13YwNWK/KXA4HNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX+K+P0w+IIlWNFh60/ZSiQJgJHMotelTSgQ1motH48=;
 b=S3IRYgd0vYhUF8xCsFA1tFRXW03koCb+QZXxyo1HtY9DphS04Lv5V28iMIU583um+WO2cjXIjDg1CtAy8l7HztsJ2YVKWHdN59H2zoYG2RorDwFty49IrNU8FLX2x8lIrIaS688w+owPiaDTlTUHsI77a/6nwBAiKjUXgFBQK5vJg4FBBF9lsO8ydv/ZWpS9Swf0NkgN319p5/6fNtW4cvKKCvPouJaqcaYeYGkEWvt1nvsHgZjDKSn43XgnVR+a2zIXRFk5pIchFYkZm29UJelPrYwQ182gJYSEFh3320S3q6dBpCY4JkGFHJXLDZ9KcyVU0UudfSezaM+pPTZBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX+K+P0w+IIlWNFh60/ZSiQJgJHMotelTSgQ1motH48=;
 b=YUe2iaPNn041SX7R0yxx1oex4X3Q68i5Mncxo/mP6qCol/7+mdIQqsEvBpavf5q5wEcTSrAcTJ7OgM8g/utz4bFb8ovh3w4hkR49S9i2RPuoc2TuBItlOTQ/jUlwr6xbfDEe6xHnOZ2V6urr5Mc3BPV5rAGYQL0l4kuE1jtfXgUYVYQyUyt9vbblqMQbf91NnYNQ+QUW+d+3dsnW0Vq3CPkVZkpM+vrB4354Kh/D8bZD3CRFDt2NldLLNbQ+F+aP8CnuuXHnrc7UtDSpu0sXAWmU8Woc6MSp/R0dDqp+zPkeb9btIQ5IiFKiSJ6Aqm8BODD8iUzWKwTYg1RAw8pqbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 13:31:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 13:31:57 +0000
Date: Thu, 17 Apr 2025 10:31:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: "Ziemba, Ian" <ian.ziemba@hpe.com>,
	Bernard Metzler <BMT@zurich.ibm.com>,
	Roland Dreier <roland@enfabrica.net>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	Dave Miller <davem@redhat.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250417133156.GG823903@nvidia.com>
References: <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
 <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
 <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
 <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
 <DM6PR12MB4313339425CB8921299AB9CCBDBD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250417012300.GC823903@nvidia.com>
 <DM6PR12MB431337B52F88E8E22323E066BDBC2@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB431337B52F88E8E22323E066BDBC2@DM6PR12MB4313.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0358.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: aa80f158-5bc5-4a54-fd12-08dd7db439d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3D3svFSzRmNyJ9eeMV/eCiVDvVtYgscmwcgptwRNPA9dmI1ST8sej7qU91oG?=
 =?us-ascii?Q?MG/av0IX2Rj/CjG2WKGAQTZvVPdBxWJSCSdJvm3fIYDy96/IkZAnIeNJefeO?=
 =?us-ascii?Q?jTsRE2fMlfrmMUOnEh23fornM37ITkeZGKlvIscE/soaK0SQ9KYpw/bEHVWC?=
 =?us-ascii?Q?9kf2r79P5uG72fzi9dIyDYX7W+AyHI7+aUx8rNNzTnSz2WAk+VWAWKw68Gcs?=
 =?us-ascii?Q?9IoNPxxcGy4DpY2NBV5tQQR5uttK6Qu6075+OapCpfU2AP8pNgi1pXnwcboi?=
 =?us-ascii?Q?8n1K9uHzWvBZA/kSeoUQ3ppSadMZs/L0Z31CtgefiK2qS5d5+jGBMjDS1otb?=
 =?us-ascii?Q?S/EudEPYXfrX6w4PPkjUXHuzJF3ynVG+d6XWe/bddMQbqv8rJqGaN4NQgV6E?=
 =?us-ascii?Q?2XdFZ88IXrU1UnYf4qCFCGnMoD8pfsb1y9Xb01M4cImWNBQA+hCne6Gm1mDC?=
 =?us-ascii?Q?dxFs+3+wgr8+CKVS77UtYRBJVScW4EdqS7MBORcFU355QOFKl8QTBLCKMJ0T?=
 =?us-ascii?Q?GYqiAjCnlf1jMvQgXANCREWNFT1aL8T7tzvtkB7EA3Tu+cE9rsY8uJCkCtzl?=
 =?us-ascii?Q?FnlGlABm+6ZF45qsz2rYKsb8JcWGB47Td1PP5hjeJ5ikXCNdoSa+gK+cmL9L?=
 =?us-ascii?Q?CqSS/U28MuIlalIfh5q4MlHiENtGZpVw11DYEeautV99t+F+vLuymkLxH2rZ?=
 =?us-ascii?Q?66DpQfYsfegOakWtWX1hu8I5tPzXBnO+RVS81YM5CLKNlU81lu90uViw28Xf?=
 =?us-ascii?Q?D78IB5opDDdqYgYe+SsfRIZ/n4JXrtraa/jav8taJm6jBWeBPcTdhCMsImgC?=
 =?us-ascii?Q?uAkmmGbxxH9t/2WRN+tfTxEcAgYqU1VOFFwC/LWJFeiW7JFW0X9fwBgttpHK?=
 =?us-ascii?Q?OQLMrS6wAHC5NPSs0aty8E6NETM0/gvyEGmvw+O+KEL4ZMrFbJoRa1VfBe6s?=
 =?us-ascii?Q?l/C3HVAKSLw1BhBiWn0PiTn4I9tte0bOE6/4PVcKNMfxPKjwWKdeRXxtLzF3?=
 =?us-ascii?Q?6tsjLFahCtqWG5Qg9KuylFoa1G684A58hqp+/ASQDZMvtiZ09/HttLfVMbn5?=
 =?us-ascii?Q?QJIb+Oi73K1o5AcYvKFeKguyrgora7tmTHighcKtVE3hy1U9s2SbNtrMwQ4n?=
 =?us-ascii?Q?+ItX5PYO1i1WvCJUY1ax0PvjJKHaxv9/uAFu6WJT4ubwBDlDO5IlEZbl2G8H?=
 =?us-ascii?Q?Ad96yLBokY45ch3DEJ+FaBog5HD1lHypfODyWh1z5SbE58102LyDIQHRx9us?=
 =?us-ascii?Q?F7FEQwn1svNwmC9oVCluLe8shRarjh9k2lPQgs70REsq6gQwbr69ygaf3xsw?=
 =?us-ascii?Q?+XAmaNa12XL7jF29JvY7DYbVUjlQ3q91CIARaAaQInSyNtw8Q9ourEbTeTg6?=
 =?us-ascii?Q?8rZrBfIIPTld9nK2UszEqlNY6qDtAT4z01JymRhibmvv3URDbRiMOipVJiK7?=
 =?us-ascii?Q?1TgIaR+2lXY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8rBjoDL+uzEQwtoxNRO5VmNeJRfB9NL0pYfLRdrOiMPGb1hgXECKuITe/tcq?=
 =?us-ascii?Q?6Rw4ghnaPxPPLrmr6wVG7qa/z8PV+6ofBh3GEPQdjGgyOtN6/PS6H5sEA1dn?=
 =?us-ascii?Q?hwit+zxy2lOBjQgpITWaSsNDtJo8kmxC71Y73vVV436oSmJAEyQvM9LG3ILT?=
 =?us-ascii?Q?w2WYfOpb/FLRQveEMh0rMpH114IPuSRBoaKhpWzEMYU3/eMmYqGqW+ovi3f3?=
 =?us-ascii?Q?WZ8sGUaRjENEzQmk30sHgniCGrVH7wT3hBV0CcWXQHUwqk8JuOVJ5r8jipeV?=
 =?us-ascii?Q?0ImwrI6KsLF0xTHCB2SjZdfs47LgjL0zWYJ/JWaMKp0GUH7yX7Ao8qKf3U7M?=
 =?us-ascii?Q?MXP/yWC6+9zVmxldMgUEw9CiH40dkys4X8EabIfCFXnPBhvZCLYH5XvSFz4p?=
 =?us-ascii?Q?ZJquRAxRT4sDR8AB8V2bwkpsR2Dbw4NWF6IV5QE6gb8sDFyOR368dqUSQ10x?=
 =?us-ascii?Q?AoQr0UPQCVLz2FFIBwSxgOjqs3KBzx1sXbz7TI+3tl/6f9HQjjLNidqr06AN?=
 =?us-ascii?Q?lurk7GQGApMSUraVD6FWJyZ2+RTfnjyYZsdNnFi2XaUXeH7C9vcAY+NZdN1C?=
 =?us-ascii?Q?t+P1YcitbefFtZSvQ69ba+RxXTBKT+78pV+2DIuRpXCP3LHnaAXQJzysIQrR?=
 =?us-ascii?Q?ZoIanPpAewRlMImjCWN4KuvUQVGPUAcm7aNuGN7duBwvSHBkHGOHppesukvc?=
 =?us-ascii?Q?CB3lKo7Vz70WydIFdlZUdQXXfFSYqJDv7wDDj/wG7kgLdlw1iOIORaneuDWm?=
 =?us-ascii?Q?P3cv3RWHarOXZM3It+p9hl7dNxuHomVzQeYTH2KYRT+u8pvhHRR0ODkFTkN8?=
 =?us-ascii?Q?/vkw2dAm4WCdhNkUBd+uEOdHcVW2Dz/1ewawuy/XUJsgzA8FKrU8x9Q5QlGz?=
 =?us-ascii?Q?fyX3LL54PfC+fOvcPOrBITDF4Gzf5KNuhRIjZplw4DXx6hzWic3++P2/XmVf?=
 =?us-ascii?Q?+ASilqLV0ayacYf39RSvxlNiYK/ufW16j1og40gqBhwgx32g87yYeLdKwToy?=
 =?us-ascii?Q?dzUIzS3QFrj61FcuRvzwP/p+6klRAh3Gdw8OXcquGztwRb+ARCEc0YkfAnr/?=
 =?us-ascii?Q?3qIUFxhg4c5eGhXSWxoddRSunS8dE/Yh40AGPAsls31skCB5/TTn6Sw3qNCd?=
 =?us-ascii?Q?xukbWJ9wDWZtfqeCIliZiVsTQ9wtGqMHH8nQ4YqbmjGCblbWvqIDsAN6Lm96?=
 =?us-ascii?Q?bGzJHkAFUU/8d44yqWM914cOKQaDjFV7+sQCnwvZgRMRzu4NcbEvd/8jw3Rr?=
 =?us-ascii?Q?k0skCfBvwmv29huLSCZv8F6HlpZWa3wTXEVpFcAfUXuvfm+vsr8+UZzyoyjj?=
 =?us-ascii?Q?ogBJTZCt6o+E8vhz3Nfr4cFWqDEhXoJfDqg8gd7LoWJ9R214HMLiS7YWFYE8?=
 =?us-ascii?Q?fC8r7tFSgjiD7BdBjD1g7F3WAz6jv+3vy0hWx3HWeQRkMxTEzs4dL70jUOmC?=
 =?us-ascii?Q?zRv7voAKfnf0RdZ8YlNbK8ZNO0CGEOVZ9OeDFyT1XZTlNbFSAFVPrHBMu9BG?=
 =?us-ascii?Q?GBtaE3MhoGZQKRpdAuERNdzQOIb/SMv5GbEYQFbt+HVhL8r/yT67j696d1Cd?=
 =?us-ascii?Q?cHggGLIKhSOkZe5bArJynMwFMvKeYDEmt5MDBgat?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa80f158-5bc5-4a54-fd12-08dd7db439d3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:31:57.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzzMSJDg0CVnE207hraook2lZRrBsoXXDh1FLIYp8mwbacesQuF3XWtWyn3AXlD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539

On Thu, Apr 17, 2025 at 02:59:58AM +0000, Sean Hefty wrote:
> > I think the "Relative Addressing" Ian described is just a PD pointing to a single
> > job and all MRs within the PD linked to a single job. Is there more than that?
> 
> Relative / absolute addressing is in regard to the endpoint address.
> I.e. the equivalent of the QPN.
> 
> With relative addressing, the QPN is relative to the job ID.  So
> QPN=5 for job=2 and QPN=5 for job=3 may or may not be the same HW
> resource.  A HW QP may still belong to multiple jobs, if supported
> by the vendor.

Yes, but I think the key distinction is that everything is relative
to, or contained with in the job key so we only have ony job key and
every single object touched by a packet must be within that job. That
is the same security model as PD if the PD has 1 job.

> As an example, assigning MRs to jobs allows the server to setup RMA
> buffers with access restricted to that job.
> 
> I have no idea how the receiver plans to enable sending back a response.

Or get access to the new job id, which seems like a more important
question for the OS. I think I understand that there must be some
privileged entity that grants fine grained access to jobs, but I have
not seen any detail on how that would actually work inside the OS to
cover all these cases.

Does this all-listening process have to do some kind of DBUS operation
to request access to a job and get back a job FD? Something else? Does
anyone have a plan in mind?

MPI seems to have a more obvious design where the launcher could be
privileged and pass a job FD to its children. The global MPI scheduler
could allocate the network-global job ids. Un priv processes never
request a job on the fly.

> The second feature is called scalable
> endpoints.  A scalable endpoint has multiple receive queues, which
> are directly addressable by the peer.  Different jobs could target
> different receive queues.

That's just a new queue with different addressing rules. If the new
queue is created inside a new PD from it's endpoint are we OK then?

> I've gone back and forth between separating and combining the
> 'security key' and job objects.  Today I opted for separate, more
> focused objects.  Tomorrow, who knows?  Job is where addressing
> information goes.

I don't know about combining, but it seems like security key and
addressing are sub objects of the top level job? Is there any reason
to share a security key with two jobs???

> A separate security key made more sense to me when I considered
> applying it to an RC QP.  Additionally, an MPI/AI job may require
> multiple job objects, one for each IP address.  (Imagine a system
> connected to separate networks, such that the job ID value cannot be
> global).  A single security key can be used with all job instances.

I haven't heard any definition of how the job id is actually matched.

If you are talking about permitting on-the-wire job ids that alias and
map to different OS level job security domains then the HW must be
doing a full (src IP, dst IP, job key) -> Job Context search on every
packet to disambiguate?

That seems like something a latency focused HPC NIC would not want to do.

If you are not doing full searching based on all allowed src IPs then
you can't have separate networks with separate job id spaces either.

But even then, managing the number space seem very hard. If a MPI
scheduler is assiging on-the-wire job ids from src/dst IP pairs within
its cluster then nothing else can assign job IDs from that pool or it
will conflict.

Jason

