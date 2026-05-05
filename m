Return-Path: <linux-rdma+bounces-20018-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAV2FPoQ+mntIgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20018-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:47:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0214D0864
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6371B303DFC1
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A748B398;
	Tue,  5 May 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QTmkuIv+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982B48B397
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995619; cv=fail; b=Uuv97+3stujfLQHKUSVQMvbopTV4RhSE2QQRWVmEku0QCYO6ZFe4lGvTfz/YpketELAAzO4ZoYWMieNkm22N0OTeRrPI0F+VhQWO7iaJm3yK6qr/p5tI70X/4Xk94gktx+uHgw5JB6af4Z1BfEIO6a0rzW99iDXLCK0DQ4uCf6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995619; c=relaxed/simple;
	bh=YYRsOFuMilofUrnc+TYuHaXu0fzMGVhyyYfRqCUWlJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bdJwgOIfjfXT8TsQRB79qPPPyN5xKm24DFNsYWUesoEgkFdwAsaFm1ekZ8GkHFB6LXqtKFl+haBVg/ZRPXU5qlLSQPCuGrEKst8y45gmtfmGTn1zj2txK0vXhKFJdKN3vganobOAIujZBh+Xv0VWIWsJzT/FXAcoEKpfGVjOj0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QTmkuIv+; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJf3GCfCsW2S2aql60+VWaiH+Igue6f6xRqM4uaVEXJZlGvKxWhi+bkB05iRWzOngcgivg86HYVV480wnPSfnwMFU6ODKUr7QcZU728Qvuv1j9CA7Kd2Ej1T8kT6Zqk9LSYRakrDZ8HYzp2jLW7d+aNUpkg0MCvgxddwr2cqgjNgT8bo2NHjx/AuHYczZre3ZaTRxGmcN5vCiC/ABj4DSJRQcC5ScikEvjGaj5ebp0Dd2B0laooUKM9kAMtzxVtbGD75JfLAi50e4YSniNFBxrienz4WGtEzYxtJ2ebKzAqlnvF3Rik3sko4H8OvK2k6um6YUefp5fL90iFKye6PVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T71I1VqW3ZhXatUjnEZ2UqRUsx+HplyGkq1nZ2sMRec=;
 b=NHzIWIeui3k1lu+oZUNsGMgyQDN95YSm3sbEdKJXkGNIy2OKXrGl7aLpI0hm+UtV1Pcw6rihgQ7fN26knckSH+tX1G+aoFS10iNcSzddbYX80ilBNbXyXCH4fzTtdsRIXMB1sTfwQFgjsL3xbAQSahxc2SRPicuC9Q9KytAS3sNCVKro1xm1ImDwEujD4DJnO/pCp8K/1vOY4sOgrIYORsfQLSXFf4EcV5Keam9IRswxv4QDt8OUW3H8GrN8XSLGqyEWc4LokCUwkV69MxMYq74W8Wts1OQwpHMX1pkbsibTkVuK35JbifqSvJ29FkEllGE8rYR6Qx/jVJGMQGYFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T71I1VqW3ZhXatUjnEZ2UqRUsx+HplyGkq1nZ2sMRec=;
 b=QTmkuIv+c7NnYEZmzhpkqwGwsYNqGm4pc8i9rTL0TJrC7635ABMSOsNsAcd+3bsC41O/iSanTHe1fOS5ihfhychofzpAwOOr4p1plftPtLeQK7NcAa/W8+5VfsAJ3XmCsKXitaGCwwjv084NpLEQ/20ywR40DxN1d3G9uvO8J5yVzHGtefSaG6ZRH2gjXyeNaEqdSeZQOc2tDDx5pKo31AWbbsyhljSAIRZ1s9zz37T7YWBCC9tpu52smgqfyS5limDSaBqIU53PqmD8/7WL5rJUHa+REl80RYXYz4qIqilKExN6af+MCOnbvGoX+JQwrgcB1WYvc+LUbmJoBLlLRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:40:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:40:14 +0000
Date: Tue, 5 May 2026 12:40:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Yehuda Yitschak <yehuday@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Expose device P2P DMA support via
 device query
Message-ID: <afoPWiiEwk5igB/N@nvidia.com>
References: <20260503150246.2349679-1-ynachum@amazon.com>
 <afhL9DLUVhnVyzZu@nvidia.com>
 <20260505081514.GA19297@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505081514.GA19297@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
X-ClientProxiedBy: VI5PEPF00000931.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::82b) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fe43a0-6ed6-4137-58ac-08deaabc9936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jpd8+8Rk8bPqHA7179GdrdW0IBSqbAcpEQM7LJ79jq5mX38fiF59Cc5HulM68MZm6HpB7X7DZvENP18HXtJKxD95FdfRqr56dsRT6wJuHTc2yz8S/aI+dYLdYATFTf1kA6WwHT2gw0eCxlpUxyYGPCquA3pXV2FMdZIdkL3eeoDx4bao+UMctw2aYhaPfFGZmcq49BeB6+ETw/yty2it02rduWsovHb5TKN/EVnWg+RccZC5ob8Aq2STVd2i0O0EjFc2KzugVHg6fCgxQRiZEM7W/3BGnTS1d1qQPWfEyuvoZPycXi0S3aNOAhADosbmTI0F+kQ0LXAKQrcuSGEW92Hk48EIgqem91vTC/qGb7qu+mnzbaDyPAJSOqsyPfK83iStoy28XtOWNj2TRQ8xhbhyuWXzuxWgXX7hmjmqwhl7KjYheFrsXmhCygIhvY6l6ZwqlefDp9ZiBIKQhM3hAFMTI2Qc3rIgO3lTKQNxL9QAn5fwFiA86tFdo96w4EzlWumBG7DWi0fP4LMGVkaJOsAvQyoiEPYgFdSxpu5WeECK385U7fqtqs0lIaG6LwrPNlZ7WWZuSEYrwhtylCxC5PleA0I8UN5GnEx2b1VbZh7DVAFssY4/XdK4XrO3ns/c0H4D4OqiUDhncRDaRHz3RFTO06YatXwJ2S0uc+LGfw6D1LwnV5BY2vSWYKop34g7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZQa3lFRHc2amZWMXRTUFV2Ty8zTzdwM3pUWDNHcFF5SEExbDlVZnpqa3Yv?=
 =?utf-8?B?b0szSlhaaWRTQmdnME81SW9qNTkrTVRlbFQ3MFQ4ZWdHbGxteG43bFY3OVF5?=
 =?utf-8?B?RE5KWUkwMjZoVjJ1Q1k5YSs2TlNNYnlkSUZHWk1jSHZxbW1STVBWNUxRRitm?=
 =?utf-8?B?TkpnMVJISGJ4dEREUld2cXZRenRMZHlmSktiM0R5OTJaMnN2RmRzc3pCSFVs?=
 =?utf-8?B?ZmpsMkFSWDFSU01DNXpJMVE3ZS9VQTVJMDJiNHV1c1hWZm44RmxETlErUzY0?=
 =?utf-8?B?SzZibCtZR2VxeTRiandCUUprSG5DNDA3T3JVbEV2WDVMbWJkTFpaT09zczhx?=
 =?utf-8?B?ckE2d2M2bmxyNG5pTm5qR21Rd2ErMHd0NWt3aTVBL2ZHdmt2UkNmUWVDR0c0?=
 =?utf-8?B?MFRyM203emxDbjNnYnMzZXJRak9zRFNBa0MxQUEvUTFlalI1UEtlbWVtYkYz?=
 =?utf-8?B?UjJQYVdVUys0U3dPNmx2QzRNTHBQdGRRTmw4SENsVUtreXJuZ0RBREd1NHA5?=
 =?utf-8?B?RTVmRmxnVDYyMURieWFvU2paVEt5eGpLQzBJalJsdEtNeUVpa0xUTHVUQlE0?=
 =?utf-8?B?b1lBZTdLOGZKM2xkZnlFNGxkMGFoTzR3Yk56c2EzOWpoUlhON0UwZ1BLS2N3?=
 =?utf-8?B?ZUFwdml4WnFjUGQ1RDMweFJrWmprQ1grMk1JY2tSbjRTOW9obDNLVmVsTHlQ?=
 =?utf-8?B?dWJjaytQdU5qcGJWeHFqUC9sbkt6dUJKZlJtZFZNVi85OVN3eDJOSmJFN2xl?=
 =?utf-8?B?TzhIU0RsaG9uUWR2b3FBUy9XTDRiYjZVRzl1dm9GNXk0T2ZHSlM1bkJPREt3?=
 =?utf-8?B?a0V0bVZqS3ZtajQ4YWxPYVpERmpVNmc4TjRNNmxFaWsyTnZJT1k4RmFkdHFC?=
 =?utf-8?B?RDdXYjc1TjZKdE9MNFMwc3J0d1UwYjdmekNhaUtxRVI3dVVxQ1dmUmN0K25p?=
 =?utf-8?B?VmtVN0lsOGlCN3ZTOC9ZZ0lqNzE0NE81bFFPbEtMS3AvOEZzZGtOT3NZVi9x?=
 =?utf-8?B?MVQzWE01T0FWbnN3eitZeWdja2ZGZVUrK21STFRCTDVCQVM1SDlyajREbVFn?=
 =?utf-8?B?U2VZcE4wb1JDUnl2aXZTN3dEdnE3aFB0UGZwbHNqbVg2QmdvMEVjWFg2L1By?=
 =?utf-8?B?SVlnL2ljaEgrZGVHMjRSa1VtLzk5bWFqU1ZuY25uMThvcGVKVFVZQlVrT0ZC?=
 =?utf-8?B?ZUFzQm5xUGdoaFRvcHhGbGVranhuMVRkUXBhVERCalB5RlBDcjRGMjRVNXZO?=
 =?utf-8?B?djRSTDVLaW1pMlhFMTFkUThROUhRQkZhRlRheWJvSVNGQ2FobVJQaFo3LzZw?=
 =?utf-8?B?NWNqaVpreDM2TDdMaXc3V25LQXo3dE8yZ214di95YmdDWU55eWpubDdJVzRS?=
 =?utf-8?B?T3U1Q3doM3Y4THRNTFNaWDVDMHZhV2ZZcGtQd0hLemlHR2dYUkRNd2hSMysv?=
 =?utf-8?B?Ulk2R0RCeXpvcXN1K1p2ODVDTDBMUm1NU1p2L2xQUERvczA3NWcvMG82VXhW?=
 =?utf-8?B?TTFaMDBHY29oTUhQYmsvR2duRndxSnJzbmJqTWxRZms5SzFLZ1JJZHRVQlVT?=
 =?utf-8?B?R0dXcU9lQjYxZS9ncHpsVDFWc1Q0bHB3QnpNTC92enN1R04wT2xlNTFlbkd2?=
 =?utf-8?B?dFdOaHMyaVk1MGM0WTB4K0ZxRmpJOEY5QlhCV0lnR2NRS0dqNGV2Lyt1ckps?=
 =?utf-8?B?R1dja1dVT2pQdkI0cDB0bE5FNjR5d0E2YTVQanVuWDVFeVUyTWVSb0Y4OU0z?=
 =?utf-8?B?QUNKb3pacW16NnVWcXlVYXFaY1QxWjhhR3JnV2hMc2hOVkFjL1BEODFiR0p5?=
 =?utf-8?B?ZnpZYTA4cVBzcnFQaFlBcU9IYnZIMkVPZnNrQmFrTlovTFdDcFZReGVmZG5Z?=
 =?utf-8?B?alRiNjd3Q0lFb0N4K1R4U3ZXMm1IT0xRT2psY3FZSjZvQmFCaWV2cjdnM0JE?=
 =?utf-8?B?S3QxZE94Yi80VXV6bC9kNG1EN0JKVDRFN1ZjeXlieExNMnJBUmN4U3BZaFFL?=
 =?utf-8?B?VzdYRlVZNnVlVjhxaGY3OWxmOWlhVUVzYkhXaUdTeWNxWkF3N3BVWklvd0hQ?=
 =?utf-8?B?MnZ1Um4rbVYxV1pGNElEc3NHOWt6eXpzTm5TT1dzRStaVDNSelp3UTRVc09w?=
 =?utf-8?B?eGExZXJwc2Q3OEZKaTRKSkovQVVwV3RCVUpNNjJ2UXRPbko0L3h5SXM1ODhE?=
 =?utf-8?B?U052TDFyMTlZVUMvN3VOOGpncEdrcXFSQk5CaXNUdWNUS3VYVmkvV09jVnBV?=
 =?utf-8?B?MTY0RmRuOVVvQnd4SmxrRWFCUjJsOThjZ0ZwMWEzejFDODd2d2RNbmlmaHFR?=
 =?utf-8?Q?UrlewtZm/wACKRrduM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fe43a0-6ed6-4137-58ac-08deaabc9936
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:40:13.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTsZolXyDLl8lAA1cp+uzy8hITyLA2s7AVNLVADV3wf8aOlRQedPUBcXWGlXTef6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
X-Rspamd-Queue-Id: 0C0214D0864
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20018-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]

On Tue, May 05, 2026 at 08:15:14AM +0000, Yonatan Nachum wrote:
> On Mon, May 04, 2026 at 04:34:12AM -0300, Jason Gunthorpe wrote:
> > On Sun, May 03, 2026 at 03:02:46PM +0000, Yonatan Nachum wrote:
> > > Expose device P2P DMA support using the query device verbs.
> > > If the device support P2P DMA, it can DMA directly to and from a peer
> > > PCIe device
> > 
> > This doesn't seem right, this should be policed by failing to
> > established p2p mappings and to fail mapping dmabufs not with random
> > user space bits like this.
> 
> The motivation here is to avoid requiring userspace to speculatively
> attempt registering accelerator MRs just to discover whether the device
> supports P2P DMA.

This isn't how the kernel works there isn't a "this device can do
p2p", the question is always answered with pairs of devices. There is
no way for a single device to know it doesn't do p2p with any other
device in the system.

> Beyond the API awkwardness, this also has a real
> performance impact — initializing an accelerator context can take
> seconds, and by advertising this as a device capability, userspace can
> know upfront whether it's worth going down that path.

This seems like a misconfiguration. Since so much of this topologcal
information is not discoverable at run time usually systems have an
external data file explaining how to best use the system. I wouldn't
expect the runtime to be trying to probe this at run time.

If you *really* want probing then it has to be dmabuf based because
you must probe with pairs of PCI devices.

> 2. When we get a dmabuf, I can't distinguish what is the backing memory,
> for example DRAM or accelerator memory and we can't just blindly fail
> all cases.

You must rely on the p2p subsystem to make this determination and the
dmabuf exporter has to call into it. This will deal with those
problems.

Jason

