Return-Path: <linux-rdma+bounces-2657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BAB8D2D1D
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 08:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EDB1C20A61
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48416078E;
	Wed, 29 May 2024 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDw9G8ta"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD2160795;
	Wed, 29 May 2024 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963579; cv=fail; b=teT5bAD1zxt8IYixVjcv+4/BK8WvMYGI6Uk9vWJwOmab9ppuV7cXQdsS1OexNPfZBumlbWllLL8TY6Gz2hs5aAEnG0TZa74COmjwFGEgOo0ueKezcAr1LETvjNwbRGc2cqCO952P/OKxUsC2X8Dbfiv7L8foBeK0Kxm/FXjLVTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963579; c=relaxed/simple;
	bh=qWnYrhBYymwAsoZq5/Gi9m4FgrQaSK6xBPeRCrK3Mrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bDhRi++tmo9CMIxIr/LLQ2CrjZXSG4V2jcL1wVSflg1w6rvkVM77+W8McdwR2XUqYdbpknnmVgp2EbQFuBKuEmGDjreP5QKByWe0qzf5zXi2/6pbQJzH94kjewyeRLNG4Hg6ioh8Oga2jKeDT+9s3BTcOAGfUvU+nqT7FTRMgr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDw9G8ta; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQS5/qLfSt0D+cUaViOl8o8nzvuGaXGiXWirXWGptmUs+NczjTfnElLnZB13TwI34mEglrzw18mbIsziBDHguKg6jz18+jAoyKEDZpqrzY0zcPwkHpDneDj5B/F/6Sa8lgZUbuZbJrN4iB+GQqI4Qw04ksb5sR4dUAYu+HacJMu2J1iOwDpf1dYWTcUV4BhKVAECPeTjy9bqmSKQ3Par5L0s6H7YQuBIWO9E8l7wy3Izu4Xc7A0sdzVekbMaSpEpG9VCczxtoKl6Iwhs0UHxlYFQCWRPW2CFpo9zk7MJhTlaEzhq4TmSvpAIvTbMNu0GgZJzyzHZD2xeK2GHGE/Mqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEbtLzJK5JAB1Al9keMLBMveKvHFR0Nq3L8vciXsw54=;
 b=eAgPjTLv/xFLNbcqJoVPsiwbrqhGgDYwUL71bP/KgknNuugguU0BySWQyDnNbpz8aizCmnXmfFTPTC3u7Lazd9RjuIqZx9oWL0PZ9jryg6J6JKBaHNJQGff9s89R5x6nVa0KyXQ1ehY1wRcB+zABktGQVZFeBVKW4211AbaYVcloRKAwD4bS1LichrDoYAk4LLgbeKZjOP4X4u2F584rf4ifRFhSMFgKNQmza9qMEP+KDnsRP2BxaLumGUMejyHRAnuzhrUEhUJUbSGk+n+ljteG4PtFJnzX8uGNYgXA7FZ7wiknaEEbzaif6GqCqPUU6nO1s0s6VALeYEcW+zUKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEbtLzJK5JAB1Al9keMLBMveKvHFR0Nq3L8vciXsw54=;
 b=ZDw9G8ta653jZAAllXw7Uds+02SIzt/kz5hZRrCVMzxFfeNCbS2EJqAyYu/qt3p2TJJfTQ29EZR22/714Ccrs/wHEmv6tKamKYNhP/q9wbxodLAqGtMIg+q7ZACv1cB7evFRr13ByZ+ohHNWw4cvhyYcqAcS2oxod8WdmGSAxyFGjrr8oREmYFV1YH5u1aTb6cMhAJVmPx/IYrkkiBO9KXYp/r6cSMPLcWs2vfvn9kIKAVAeCE14Djkt9OO/X1OVE3hiIeo55RGUnFxmm4qQO6RXWQqEw63TyfSjbZD8RrhTrf2XqVa9Vma9GjjUsn9iNV6nCkkRGSZ4Gawgg3EgFw==
Received: from CH0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::13)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 06:19:35 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::51) by CH0P221CA0005.outlook.office365.com
 (2603:10b6:610:11c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Wed, 29 May 2024 06:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 06:19:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 23:19:22 -0700
Received: from [172.27.34.245] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 23:19:15 -0700
Message-ID: <3860d55b-d1d5-44b3-8089-aba93027dda5@nvidia.com>
Date: Wed, 29 May 2024 09:19:13 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/2] Introduce auxiliary bus IRQs sysfs
To: Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <2024052806-armadillo-mournful-6b23@gregkh>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <2024052806-armadillo-mournful-6b23@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f244006-8ab6-464b-5de3-08dc7fa74f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlVLbzNoUHF4bmlrdEVhNnNGSDkzMFFRcXZHdDVUNDFwMG9zLzM4OTUwOWZW?=
 =?utf-8?B?OVk1WmFXM1ozNHJBeGtnNFhPQlJQOXhwZ3VqaW4yMWJZT0JYSTZNN0lPQ0xB?=
 =?utf-8?B?ejJFclFOZE5pTEhwSjFEUlhVNlVqYjNPcUVGaGtRRmVYV0o1SU1vbDJKSjlv?=
 =?utf-8?B?YzBrWU9NWVN2b1d0Vnl3UGVJcDRZaitJVlVydDBuZ3NGejBScU1WSWx1endj?=
 =?utf-8?B?MFM5QUQ1TUlZaUx4REtwdU5zU3pwZ0ljRUVPR0ZPSTVCcW0yQWxwUkt0V0Ux?=
 =?utf-8?B?a3hOOU5rQW91QWJQdDh0amEvWW9IT04rSE1GK1pZMHVzcXRDOXJXZHJhQ1Ux?=
 =?utf-8?B?SGZsMTVFakhyVjVQWGVDV3duRkU5WjE3S29qZ3g0UHl3NTdja1FqelNwcGZl?=
 =?utf-8?B?Y3ZQMW01T2tJaXpKMUdoV3l6YmMxOGxqT1p5c3NpaU5pNGtpcStkcHVHRDBT?=
 =?utf-8?B?cGZ3UGZnUlczUXJmdHNoaFNsUFE4SEtmY2NzQW9jbm1ZRFJyeDhjWEZEd3ly?=
 =?utf-8?B?ckZnT2JEaW51NXdNMEp0Y0ZVc2t0TUlIZTljSUV0VXZCRUdiVEh4WENLUjVz?=
 =?utf-8?B?Yi9NZUNweE9Kc2N3NUxxWjlZQjdkb2R0UWs5Q2tOcFlMRkkzMHNMcHBudXVT?=
 =?utf-8?B?enplNjV0dTVWeWxPMUlGOWdZc2k2Mm92c24rMzBidFVka3RlcCtacFRzelg0?=
 =?utf-8?B?ZURnTWp5N2FBZWdtTlVaRFkxQmFjMnl5czQyRXV3emNEcjgzQ3F1TnJWeXBk?=
 =?utf-8?B?N0x5T3JyS3BxRFppRmtGaGZlQmd3MThJcWpaR3k3M2RZbmw0ZUl3b2RYSzZw?=
 =?utf-8?B?YmU5RVZNSGI2amFUTXpSYkVpMlROSVNQOVJUYjNRK0ZQd2VDeGZLenc2cnpy?=
 =?utf-8?B?VSswNzgzRlhjY2FtaWVDK2MxbkYxZzFjWnJlWldHSEd4SkxxZTRrazRRSm1E?=
 =?utf-8?B?b2VwQm40U1pCVXJ2T05ZS1NHTTVrZ20rd2wySEVpQXdqNXJYcEl0MTNoUVNM?=
 =?utf-8?B?NUZZTnZubSswcVY5YVYvTnZrdmxHU3dnd3VvN1pvbjErY053M3ZEMXJWTS9C?=
 =?utf-8?B?T1N3c3hIRU4wOWlpaTRnQnVjdkZyVDl4TnZkbC9aQnNVWkg2Y1RrSDlINFBr?=
 =?utf-8?B?VHgzbG80dEFVUWlYcUQzY1AvYU9BcVBLUGErWFRyT1R4bnFMTUlYRVB0K3Ra?=
 =?utf-8?B?d0NaS0Z2MDJUYVhSNTZIa2ZwbUNocFdKSGZHOFIvakNXV3d4TS91K1RHUWpJ?=
 =?utf-8?B?STJiaVlaMGVkZ29DOUxSSndpR3JjY1BBaGVHcXd2YnN5d05GRTZySTRwT0ZD?=
 =?utf-8?B?OUpjamtNS2pEUGhnSmFTQlY3akFCZWk1VGtaL3hhYzBrME5XMk5JRXJiMkZC?=
 =?utf-8?B?emIralphcXI2UDNXa0d6aEtPQms3cm5QUVA0Y3JNeWNzbW50VVlHRHRhc2ov?=
 =?utf-8?B?amJRa2NIekxWdzY1bHBhaTRlcFZYdUNJcTRBUjd1ZGI4eXdwSHJJdmUzZkdp?=
 =?utf-8?B?SmhwYTloamx0ZEtheXBWaDN3SVRKTVFpb3dUUVpSQ1FkdHI3Nlh2OVAxNFY4?=
 =?utf-8?B?cXBnemxrQSsvTEFhOXpoNUN3ODFEbGF1UXY1UUl5VWtXVnV2K2VQRFBhcjlm?=
 =?utf-8?B?ZGZ6SS9XN1Q2dHBZeUQzYXVzTjgxdkY2T2sxcDFCaWI3dkhTellpYXowakRS?=
 =?utf-8?B?b0dTbWpjZzBMUzQ2R2NveDFKaWJpblpka1JvL29mZlpLMTg1MndobVBSbGpV?=
 =?utf-8?B?WG1sUHVnVzQ2QXoxTkJFczRwT2RPWkM3OVpmb3I5b2pJOE1BWFBrS0R1M3Bx?=
 =?utf-8?B?TzlvNnpyalRsWlRsMGxGeXpSdFJXMEJ4ampRdmUyTmRwendZallRSFM3d0Zs?=
 =?utf-8?Q?lny+QmqmuQSmY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:19:34.8652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f244006-8ab6-464b-5de3-08dc7fa74f88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732



On 28/05/2024 20:57, Greg KH wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, May 28, 2024 at 12:11:42PM +0300, Shay Drory wrote:
>> Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
>> IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files. PCI
>> subfunctions (SFs) are similar to PFs and VFs and these SFs are anchored
>> on the auxiliary bus. However, these PCI SFs lack such IRQ information
>> on the auxiliary bus, leaving users without visibility into which IRQs
>> are used by the SFs. This absence makes it impossible to debug
>> situations and to understand the source of interrupts/SFs for
>> performance tuning and debug.
> 
> Wait, again, this feels wrong.  You should be able to walk back up the
> tree see the irq for the device, and vf, right?  Why would the value be
> different down in the aux device?


you are correct, the IRQs of the aux device are subset of the IRQs of
the parent device. more detailed answer bellow.


> Does the msi irq somehow not actually show anywhere for the real pci device in sysfs at all today?
> 
> What does sysfs look like today exactly for this information?


The IRQ information of all the children SFs of a PF is found in the PF
device as one single list.
There is no sane way to distinguish which IRQ is used by which SFs.
For example, in a machine with a single child SF of the PF 00:0b.0 we
currently have the bellow:
$ ls /sys/bus/pci/devices/0000:00:0b.0/msi_irqs/
41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58

the above are IRQs of both the PF and its child SF. from here we cannot
tell which IRQ is used by the child SF.


> 
> And what about /proc/irq/ and /proc/interrupts/ doesn't that show you
> the needed information?  Why are aux devices somehow "special" here?


/proc/interrupts interrupt name is some random driver choice. There is
no sane naming convention and some small few bytes of upper limit of
what the IRQ name.

> 
>> Additionally, the SFs are multifunctional devices supporting RDMA,
>> network devices, clocks, and more, similar to their peer PCI PFs and
>> VFs. Therefore, it is desirable to have SFs' IRQ information available
>> at the bus/device level.
> 
> But it should be as part of the pci device, as that's where that
> information lives and is "bound" to, not the aux device on its own.


Auxiliary bus level SF device is using that IRQ too. So it is
additionally shown at auxiliary device level too.


> 
>> To overcome the above limitations, this short series extends the
>> auxiliary bus to display IRQ information in sysfs, similar to that of
>> PFs and VFs.
> 
> Again, examples of what it looks like today, and what it will look like
> with this patch set is needed in order to justify why this really is
> needed as it seems that the information should already be there for you.


full example:
in a machine with a single child SF of the PF 00:0b.0 we currently have
the bellow:
$ ls /sys/bus/pci/devices/0000:00:0b.0/msi_irqs/
41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58

with this patch-set we will also have:
$ ls /sys/bus/pci/devices/0000\:00\:0b.0/mlx5_core.sf.1/irqs/
50  51  52  53  54  55  56  57  58

which means that IRQs 50-58, which are shown on the PF "msi_irqs" are
used by the child SF.


> 
>> It adds an 'irqs' directory under the auxiliary device and includes an
>> <irq_num> sysfs file within it. Sometimes, the PCI SF auxiliary devices
>> share the IRQ with other SFs, a detail that is also not available to the
>> users. Consequently, this <irq_num> file indicates whether the IRQ is
>> 'exclusive' or 'shared'.  This 'irqs' directory extenstion is optional,
>> i.e. only for PCI SFs the sysfs irq information is optionally exposed.
> 
> Why does userspace care about "shared" or not?  What can they do with
> that, and why?


If IRQ is shared, userspace needs to take it into account when looking
at IRQ data and counters such as interrupts/sec.
Also, If IRQ is shared, user better not mess with the irq affinity of
such irq it as it can affect multiple SFs.


> 
>> For example:
>> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
>> 50  51  52  53  54  55  56  57  58
>> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
>> exclusive
> 
> "exclusive" for now, but again, why?  Who cares?  These are msi irqs it
> shouldn't matter if they are shared or not.

hope I explained the current limitation and the proposed solution above

> 
> thanks,
> 
> greg k-h

