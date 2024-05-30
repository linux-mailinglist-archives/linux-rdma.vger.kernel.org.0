Return-Path: <linux-rdma+bounces-2691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21CF8D4DA7
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 16:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92674284CBE
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C796186E5F;
	Thu, 30 May 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mko4bo5X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6031186E26;
	Thu, 30 May 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078459; cv=fail; b=dMJyORCS9fqGeQ99kzRWXWl7rvLtWrzU1MMDwJpBynafeD59/kwzNGKv+JI7Jijsg3o0AfFmA89IyVvA8F3sGq/mgz/0XvUsBXDWCxla4fANIqic1xoGEH+cJp+oyKJLBg2G+CWjje0sYWIw/1WFYV+8DU3uKJsjQKjb6e3NwWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078459; c=relaxed/simple;
	bh=obovmpkAt5xHxbteFv0/98mlr01bv0idGH05lcqc5hs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=oB31jtNY0BQoUlWOE07sGIeEu74PxgH8u9d3H44CAsVPYQithgr91TKuV+YkhvvpYdlxN7SY3f1YN24YD7vZLdmeiChK6KYnaTOdtJcp3ap0oeeDmE8HU73e9kGe2HTCDJ2bNXXM9faPGlzJQc22JoSHjIPoZoZIIsTm8SnM6lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mko4bo5X; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PugQifAsvhlKThUDA8aiUIAqaZKrvSfgYRSgV1cF7GMWw/T0EdgSj7IxO3/2YXeH6Cnf996O5LLGxAmCY+dCjPulh+/zlR+4GbU+4WBDBiEIMQ8vdPoSCpTuvXGxIuvxIrlsaIIpD9EeY5jAVOOoQJZ/tuF7CVOCMUTkFGmWEYAw/uXXk9jRP5wMeyhQ8/U81gTzGNuXTwJvMgSXd1nBwqnRFkh9+LJTBDXP+y9SgwBKyZSbqcsZIdOP1lSiDHVjJXdYkBgiBRIIieQ7n/+ZI6AVI7N7H7k8gkO8Ov0963OIMY2oQssyQ6JXmMp5+IKoSArjmzvRAvaYitdT616SvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy2A//jSS5+WPohsXkoMg+NA/BzYvGmR7IEswa1rFuk=;
 b=mIeREqNzip8RhoaRWu4bo9JLPQIld0NPtx2Dcea4xXt9hSrlBm5TVuvXMcJXASTe/Rl/XhCSbHdkf3xj+SEeunvfz4wDr9NAnI6k7KSHR+1xJo1v+wUrPuIHdJJpi94ouMLTHB81QD0370PmPhlGXSfVSdulXDpo4ayK9Eg+Vbo5aym+4mS/ZHeShXHsOk5ID+EN3JoWDZxvoRodSpUDwneG6vLee9y5WGiY+jIFoch5esdLs4FF+b/SwlJCOjf4zpP4uW+1aT5G7gZ4tKBUcHvT8/94e1ynie+ItuWhSaOCKGSIjc1dr31vmt4vI0TG8u0jhcAP8C0D+6UlV1cRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy2A//jSS5+WPohsXkoMg+NA/BzYvGmR7IEswa1rFuk=;
 b=Mko4bo5XVbZ3EKJSq5iSpG2URKt+ncdOKAp8cRc4qj9uh0djBeRQm5JfgSyMNF8kbbRzpoC1EOkmH91e8X+M5UNtrY+crqRBCM/EbOgw2tIFgFrLDB8vjGfHLtOAR/MZ2EcoWHV91ILBU65NolT/R1yM+64hdmagBQCLNNP7CitXN32rQzQa6PvOW2JSZqLw0sLY82eIk6SEv8fccF56bnYufVkbSwA0wSvCilNrTgQx5WFnW9edO/67OOHv9gojopEqK0Hdayn06VfhHFqbV7vrJL/vAnupBOlCKhnUvxuXMVzUWFuGDeV1kdPU814Niyy8WhGE61X+zAGanqIHDA==
Received: from BN9PR03CA0671.namprd03.prod.outlook.com (2603:10b6:408:10e::16)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 30 May
 2024 14:14:14 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::fd) by BN9PR03CA0671.outlook.office365.com
 (2603:10b6:408:10e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 14:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 14:14:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 30 May
 2024 07:13:52 -0700
Received: from [172.27.34.245] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 30 May
 2024 07:13:48 -0700
Message-ID: <cac09781-e0b3-4646-974d-519184f63a81@nvidia.com>
Date: Thu, 30 May 2024 17:13:45 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/2] Introduce auxiliary bus IRQs sysfs
From: Shay Drori <shayd@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <2024052806-armadillo-mournful-6b23@gregkh>
 <3860d55b-d1d5-44b3-8089-aba93027dda5@nvidia.com>
Content-Language: en-US
In-Reply-To: <3860d55b-d1d5-44b3-8089-aba93027dda5@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: a1537940-7a6e-477b-0b8c-08dc80b2c8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXM1Tm15NU5paml0VkExWFB2V0R3Si8zVHBaeVZpT2hoQVNlNkJhNSt6dVhZ?=
 =?utf-8?B?RHZwby9JM1JWTDBUV1I2OEdpbzFhSzNtcXZrV2FJOVU5NnVyN2loRzJxZzRR?=
 =?utf-8?B?ZVRGSXpZbXpEeTBNN05yTGM0ajA1YmVXZmRleGZwYkZoTVpSckxlb0ptV0hN?=
 =?utf-8?B?amFYVHd0ekJlYUlaTU9BbjA2NXI2SHJVYmx3MG5DS2IyVExyU2lqMENZK3ZY?=
 =?utf-8?B?WkZlOGpTZGdWcFNPS2I2elRLMExPS3BlUVVxVTJ4MTh4QWYwZUdYNDF5bUhY?=
 =?utf-8?B?UFc1SGE0bXR4aTVSWU94YUlCZGJpR0M3eWpUNHN0UDU2N1B1bVZCZDAxZVpu?=
 =?utf-8?B?L1pVSndBdWE0UlpCMDlMVWZ4M0cvUzhiRUhqakZWaWFOdlRjVnlOV2dWVVFR?=
 =?utf-8?B?OE9iQnllWlllTExEbUYrcGVUVkR6cXk0cEp4MWhOVmgxNXNKaGRMUnJ3UExL?=
 =?utf-8?B?YjFtVCtkdmxzZlFWanYrL296eHFHVzh6Sjhpalp2bHFqRXRVTnRiQU5aVlR5?=
 =?utf-8?B?UXN3ZHpGUVRLNVNyZjl0OStZa0JycjlNb1Qzd1ZOZG9WN1Q3WFE4N3UrcVJ6?=
 =?utf-8?B?U28rWFo1ejVNakl6UHVQYmw4MmEyNUJ5U0RSUHEyeFhTQjA4cWRXUXduL1hN?=
 =?utf-8?B?OGxGNnA1cm81dGtYamdBeHViaUxnekk4b251elJQcUFsdG5tZHBLMDBPM0w4?=
 =?utf-8?B?aXNLSHMxaFFNaGlnR0Z6eXNGM2cybGkydkEzSWJaRTB1aVFreWhIbElTbTcy?=
 =?utf-8?B?NWYySCtLWHNUajdnWDV3ZFlNVzZoN1NKSVkvVUxkSVRaVUJPbjdiSnpRN2hX?=
 =?utf-8?B?Y01tMjZGdGd6VzFxZUhKa0VPMEM0OHBDRzhyR251SU9LeC9zQ0VFNU9qL1VZ?=
 =?utf-8?B?Q2RrY0pSZGx1VEpIYlN5ZmJtU1hnckJQTkRJUFNvK3ROSUl2eDRVYWxocmhw?=
 =?utf-8?B?dGNFQ1FreWhIVnp6WnpsYWQ0cTllWFhLdTZ4c2h1bEM1ZGFJNzcySVdidjVT?=
 =?utf-8?B?ekI2THNibEtoTnE0WmhqTHZrcS9sajkxQmtESlphWlZkQlJXZjdRRGl1U0NM?=
 =?utf-8?B?cjNnb3d2bFpTTUhJZUpUWUNhWFVsY2tWa0hIMytoSTBWbzV5Q0FDSHlaMWda?=
 =?utf-8?B?eW1hZHNrY0xoUEtyK0dHNGpqRGdieE9lL1c0TWx1cWc2NjBCUEhsaXM2aW84?=
 =?utf-8?B?aGM1MjY2ejBRSmZSOGV1VkovaFI5MUF1NWQvNUx2VG45aHBjQWpEb2hkNktS?=
 =?utf-8?B?TVloNmpzcjZvaU9CZUVrZGZ6L3l6RklDMHVnYStIQnkxdmMrWmdVeWlYVk9s?=
 =?utf-8?B?ODlzcndHcEF2eW1QR3BZMUZZUlZ4V2d5WlQwUGtYZE5KYWlzcFY0UDNkYXVU?=
 =?utf-8?B?K01OTGJEYWlmUzdlYkIrYUJUOFlPWDRacGtLSEl1blQrdjQ1bDh3bXlML0lW?=
 =?utf-8?B?djdnMGMzWmVTUVQyUGhSM0ZlaWVCUHdEOFNQSjlOZnZkaTBDbEYvUFpsZFdK?=
 =?utf-8?B?RGlVdVdVR1VWTGdCeUUwVUpwRHdVQ0VOdlZGODZadjRmVVgyTEg4cThycFEr?=
 =?utf-8?B?ZHUxSXJRc2pEZlN5MkljVW9OZTRJVjVsdjZUVzZDbjlJbENMWk1KYmxId2I2?=
 =?utf-8?B?VFhLWHcyUnpCdkMvRzdGcnFTUjFyTDJrNUVXYmJSSkRLMlYwSU5uWGdmYXFB?=
 =?utf-8?B?bldzbGlGZXZvUnBtOE5wNlJZcnl4N1Y0SklQMG1pLzE2S0lMN3NmQTF4QzV4?=
 =?utf-8?B?UG1TeW1GOWlUSHM2L25JNEUvaXFWbHAyWVZ4bnYySFlFVG11Z25vRExOL3hn?=
 =?utf-8?B?ckhYNUxHZmdQa1BNakMzeFJKZ21KQTladzg0bytiLzRzZVNJOTZZZmZ2OXFq?=
 =?utf-8?Q?7bfYBOwVtINfa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:14:13.9872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1537940-7a6e-477b-0b8c-08dc80b2c8d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598

Hi Greg,

Did you get a chance to see my reply? Is it ok with you? I would like to
submit the fixes that Parav/Przemek suggested if no further inputs.

Thanks

On 29/05/2024 9:19, Shay Drori wrote:
> 
> 
> On 28/05/2024 20:57, Greg KH wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, May 28, 2024 at 12:11:42PM +0300, Shay Drory wrote:
>>> Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
>>> IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files. PCI
>>> subfunctions (SFs) are similar to PFs and VFs and these SFs are anchored
>>> on the auxiliary bus. However, these PCI SFs lack such IRQ information
>>> on the auxiliary bus, leaving users without visibility into which IRQs
>>> are used by the SFs. This absence makes it impossible to debug
>>> situations and to understand the source of interrupts/SFs for
>>> performance tuning and debug.
>>
>> Wait, again, this feels wrong.  You should be able to walk back up the
>> tree see the irq for the device, and vf, right?  Why would the value be
>> different down in the aux device?
> 
> 
> you are correct, the IRQs of the aux device are subset of the IRQs of
> the parent device. more detailed answer bellow.
> 
> 
>> Does the msi irq somehow not actually show anywhere for the real pci 
>> device in sysfs at all today?
>>
>> What does sysfs look like today exactly for this information?
> 
> 
> The IRQ information of all the children SFs of a PF is found in the PF
> device as one single list.
> There is no sane way to distinguish which IRQ is used by which SFs.
> For example, in a machine with a single child SF of the PF 00:0b.0 we
> currently have the bellow:
> $ ls /sys/bus/pci/devices/0000:00:0b.0/msi_irqs/
> 41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58
> 
> the above are IRQs of both the PF and its child SF. from here we cannot
> tell which IRQ is used by the child SF.
> 
> 
>>
>> And what about /proc/irq/ and /proc/interrupts/ doesn't that show you
>> the needed information?  Why are aux devices somehow "special" here?
> 
> 
> /proc/interrupts interrupt name is some random driver choice. There is
> no sane naming convention and some small few bytes of upper limit of
> what the IRQ name.
> 
>>
>>> Additionally, the SFs are multifunctional devices supporting RDMA,
>>> network devices, clocks, and more, similar to their peer PCI PFs and
>>> VFs. Therefore, it is desirable to have SFs' IRQ information available
>>> at the bus/device level.
>>
>> But it should be as part of the pci device, as that's where that
>> information lives and is "bound" to, not the aux device on its own.
> 
> 
> Auxiliary bus level SF device is using that IRQ too. So it is
> additionally shown at auxiliary device level too.
> 
> 
>>
>>> To overcome the above limitations, this short series extends the
>>> auxiliary bus to display IRQ information in sysfs, similar to that of
>>> PFs and VFs.
>>
>> Again, examples of what it looks like today, and what it will look like
>> with this patch set is needed in order to justify why this really is
>> needed as it seems that the information should already be there for you.
> 
> 
> full example:
> in a machine with a single child SF of the PF 00:0b.0 we currently have
> the bellow:
> $ ls /sys/bus/pci/devices/0000:00:0b.0/msi_irqs/
> 41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58
> 
> with this patch-set we will also have:
> $ ls /sys/bus/pci/devices/0000\:00\:0b.0/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> 
> which means that IRQs 50-58, which are shown on the PF "msi_irqs" are
> used by the child SF.
> 
> 
>>
>>> It adds an 'irqs' directory under the auxiliary device and includes an
>>> <irq_num> sysfs file within it. Sometimes, the PCI SF auxiliary devices
>>> share the IRQ with other SFs, a detail that is also not available to the
>>> users. Consequently, this <irq_num> file indicates whether the IRQ is
>>> 'exclusive' or 'shared'.  This 'irqs' directory extenstion is optional,
>>> i.e. only for PCI SFs the sysfs irq information is optionally exposed.
>>
>> Why does userspace care about "shared" or not?  What can they do with
>> that, and why?
> 
> 
> If IRQ is shared, userspace needs to take it into account when looking
> at IRQ data and counters such as interrupts/sec.
> Also, If IRQ is shared, user better not mess with the irq affinity of
> such irq it as it can affect multiple SFs.
> 
> 
>>
>>> For example:
>>> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
>>> 50  51  52  53  54  55  56  57  58
>>> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
>>> exclusive
>>
>> "exclusive" for now, but again, why?  Who cares?  These are msi irqs it
>> shouldn't matter if they are shared or not.
> 
> hope I explained the current limitation and the proposed solution above
> 
>>
>> thanks,
>>
>> greg k-h
> 

