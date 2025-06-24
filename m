Return-Path: <linux-rdma+bounces-11586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C288AE6649
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 15:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117F03ACDA5
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3332C08B0;
	Tue, 24 Jun 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="koYkmVbw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dQDvarBN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D702C08A5;
	Tue, 24 Jun 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771565; cv=fail; b=kp3USTkvZEpPQ81ifYfPaXx8f9Fbg+0OaECKJaPQwktIwI0POK+mcRVjeu8z+F/TQbXitjDU5SJhYQz+yF0LA1/W9BvKqjeNNe6LnZvV5t5MatJE5BKDas6oPmNg/lmqLC4fiaqF9tF94emydn0jte9+QZJvowZHszNJ+u66w+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771565; c=relaxed/simple;
	bh=lrgOBvUC0X/MoLIP3dr3b+wwZ3QVWGFKg15Dm0rhGAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HhSh0C3gzQoZsN4HZzOOEJfTU4GQOkroa3mjBo7pqdgVo0Hi2S9G2D/vS1I7OcISPx9qsRfD78Hkx9ySp0UIyHAhElKYZ+8OomVzcqsqPIeN3EPq9WRVNtRX3ZDn3665ad21UyNA0qx1LyGJHy09AVub9JbRyZO7uhCHtWInhI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=koYkmVbw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dQDvarBN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCiHgA006386;
	Tue, 24 Jun 2025 13:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gUbzMeedX8vwWGoM7K7GQis8uWtgoJChE+QvNQP1Icw=; b=
	koYkmVbwJMN7icykNLxtwJ1gx4ptYhsw4S7WEXbUz+ILn7MDx7VFLM2qWs9mO49i
	GG/QB8Ig2H26RHPAcFBVlpPIZARv12O/9z47ZKkBD+qV212v2OQrBXJf4b7BEXOU
	alcYYJh6HEH+IWA44mCRGArjPW+7UPZ7mmAuZFQ0ZaLi0w1lsbS0ZLgnnbGH+a2V
	Ono+51EJnqmJ9LGIHIBPxSmSr/+x9pePKQQwopy05dWm2i4dVXeEl5+2Mxee7EJl
	SHDuOvppwEqjS2chRixIiINXpI8DHfP1+mmOa2DdfkC5C1KxgeWKow9oTPf0Posa
	lD9daRUkxDd/sniFRHn6dw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8mw24q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:25:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCqr1D029046;
	Tue, 24 Jun 2025 13:25:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpq4uxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMilWaUog3fhA174tn/sKGkGMdSBPc4LsWiLIkXLChhns7NEFFFQ9BUjcknkjkikHvYwIWPvX53YmEM8TUhjXJbg5ys6LUZ05K95yw2k9BFwR+gALzBnlfUWT/0+ZrOwq1hCeN+xa5wHNyldaELilmaeKs/vUOo7qt0okFJRxhgo8mobTPDv3z5ZvsSFjW4PC2ggVuEY8+eohyKBup2k/Sk25kRefBtZ3fl/kXNFt7HyFQJBQ76pEL2cx+Exlh6viuInMNvasg0CV9axjSBpfdl/kF/hxPxDdEymPEx6+uLO1S5V43rQn/EbyUgZ5js0qhVOgbeV/KGCep9vGmz6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUbzMeedX8vwWGoM7K7GQis8uWtgoJChE+QvNQP1Icw=;
 b=PSTwNNQg6AGny+pwP3Af6DTu2VuF6rFrsqdlCiSU/UIWQ+kZPavx5NHRzNbuIleZs0hPTXI+eHx0KlB7J4JF5lcmZqHKEEM8oHvRD4He++rQdBz0nUq1PAmUARuxwfd8zPvY8q7L7paxwyuln0eThuoHcsxr/TYcpEKpVU/LKS5WooeWzR5uG2F8IvlzVuonICU0N1qhEgmrpobgwXJwEWtEC63XIUzIYPTWyo3cXJohqazUOcM+0CjsJNl1z2sZW4SdPYHC5i30L7sWCfzGZkd7UcxBpcBR9p+xaOe8iw1xwEyW9hikizTTxAso1i05P7ZpXdYH5335NvO65QxGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUbzMeedX8vwWGoM7K7GQis8uWtgoJChE+QvNQP1Icw=;
 b=dQDvarBNDcQyMkD1XnA3hmQc5iR7inUwUHlvaBsO8FaB4vPU+mECL1HTPcY+4SAZsdehNAztThhhqP3ucEpJnYpCQTp8HgN5gQJobhYAyJedw3A/NYntTcMYULSkMOtoR7SRfgAqEcOsHnlD0KVFAOfrUnYsMkSoWtLZ2wc9hgQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7207.namprd10.prod.outlook.com (2603:10b6:208:408::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 13:25:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 13:25:34 +0000
Message-ID: <2abd3273-2b23-43f7-955f-144da4ed29a4@oracle.com>
Date: Tue, 24 Jun 2025 14:25:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] RDMA/srp: don't set a max_segment_size when
 virt_boundary_mask is set
To: Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Laurence Oberman <loberman@redhat.com>, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
References: <20250624125233.219635-1-hch@lst.de>
 <20250624125233.219635-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250624125233.219635-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: bd63ef72-0d2e-48db-0933-08ddb322993e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlJNcklYVDJhY1doV0ZHNlpJMWIzV0hEZEZRaHBNYWJTWS9SU042VFhnNnlJ?=
 =?utf-8?B?TXZWdUlqVHhvQUJENk1WQStnQ01ZUHU3YkZDbUtxWTAxSzJpVE5PVUR6aG1P?=
 =?utf-8?B?djZKcDVHNVEwZG9pUjFFQzlUdjV3RXlqNGZNQjlHbGVCMWo0N2xLZnJGQWFF?=
 =?utf-8?B?ZDhCV0tybFdYQ2tpQ0pob2szV04vNXpWUE1IOXRnOFN4OWlQNDR3UDhsSXlT?=
 =?utf-8?B?dXd0cXNPTHdKb2FMeU9Ib2dmTXc5SkJoRGYvUU5KYjBSZ1oyd0s2dktxWWtM?=
 =?utf-8?B?ajRaejNxdGZXNEtROTZTdE1BZTQ2TGxqYU5iNWFLeDYrdXdEbnpEVDFMdmJO?=
 =?utf-8?B?YUpRQVc5bmZxYTVHL0l2a2hjeWxIeFVCL3JDcURZT2JJODlDT215aFFYSHdz?=
 =?utf-8?B?NXdHcjVRVUtsbmNTSnl2WmVmKytma1NEYnVJeXd0cjRPSkwyb3pWdlh1NWxv?=
 =?utf-8?B?QWNYTDh4ZzRvNms1ZWUwdCt5Q3BraUJRcW16T1NOdnBCZE1YRVQ0aUVsTTV6?=
 =?utf-8?B?bmxaMmlHcFk2WklqVUFKZ2xad0RocnYwM2ZyMFdtK2dTN3F2M3hMaCsyNnh0?=
 =?utf-8?B?Y0RFTURQZXBjVW94RDdIUENNbGNQbEx1b2k3Y29RdVNwem1SZGlqLzJsclNu?=
 =?utf-8?B?L0Fnd3BtMUE0S3JXOEdDeERpUVJWbFAxd0NjMk52MnQyNlJVMTJxeS9LSU9a?=
 =?utf-8?B?QTYrUG1WOFluaWkwQXBmWE5RcUNlM3lJekJHVmNkZjAyK255eHZIT1BsRnc5?=
 =?utf-8?B?ZDQvc1FselowMmx6cDB5R0tBWDRTQmtRU3FEMWNRK0dkVGVRRzZKYmc1SmFM?=
 =?utf-8?B?ZXN2U1IwY1ZJRktsUmM0eU5aOWxzVTVQUkJsZ2JVNjg1Q1VyaTZxamMvaXpa?=
 =?utf-8?B?cERhOGYremp0M1ZGNnVPU2EyMFUzbDAweVVRcmo5MW04VnBwc2Rhb2hWUXgw?=
 =?utf-8?B?RGV6bWV6VWVRcnlGNERRUE5tY1RLVUxSd3l1d25qOHEwY0hkTW8rcTZlY0Ji?=
 =?utf-8?B?YXozUWZjMys0a08rUHNRT1lzTG1PUWsvWm93czJTNVRndnp1eVlKbTRPaHBI?=
 =?utf-8?B?UzJxYlBPU1JyQVZ4RzA4SlZvcGU5UDBUb0ZDcktpMythQmVrUHZzYXk0WCtK?=
 =?utf-8?B?SG5CeG0ybjN1aS9Ed2ZBRVpXNVdxbnQvUkFwTHdGMmlMZ3RSaUQ1NVVLWkdl?=
 =?utf-8?B?ME1pSWZPbkpYNE5uZmloa2hnQzhFMUVNcXBrakpCVUx0ZlpXWURRVFRjbElI?=
 =?utf-8?B?ZXIrTFRyNkVYVjRJSVB0ZU12TFBQengyTlZWeU1CTWpKTWlxanBKWU81OHg3?=
 =?utf-8?B?VjB1UXc1QWIwN2JaNHNEMEFtSCtoQnorOVZ3NTRnSDRVN0xobis5UXJDMEhJ?=
 =?utf-8?B?ajE5VjdwRVF0cVZ5RFg0TVZySjJlcHp4TDdkNEdXbjl5WlRHM3JBdUlwYmtt?=
 =?utf-8?B?b1NZOVFiamd1TngremhWM1J2SUliWExwa0hoMVVGTS9pTEFuenZhVEMxOW9E?=
 =?utf-8?B?R1g1QnpoY1RvQThJMXY3azUvdldJRHVLSnRmcVhhaEdlVkQwL3E4UWNidW9h?=
 =?utf-8?B?R21Mckt4TlVqNVV4cW1jVXkzUzB4TjFwOEZBL2UxWjE2QStmY2o4Q2NKNWlB?=
 =?utf-8?B?NU5KUWcvZzVVQ3VxYmtXUlVQVERyYlZIS2sxVGx6SS96RSt4ZHI2Z1VLcHIy?=
 =?utf-8?B?MXk3ZzhCbldQSFgrUmFXL0hPczY4SzB2QUZvVmdiM1M4QnBFcnlWeTJYVjNx?=
 =?utf-8?B?djNjNlpiTVBRMDA5M0xsM09PeDFIOFVaVklDQVptbFFzVzZuMWJlejQ5bzNw?=
 =?utf-8?B?MjcrdnZvQlNNdWxNZXM4dTUxTHVObFJ4T0JXL2Z5QUxRTlMxSlMydlZyWDFW?=
 =?utf-8?B?djZITTZVcEJjVVVjWHJGZzlYdzFLYnZwYmJFVzhtbzJucjJOdFgrQUQvRER3?=
 =?utf-8?Q?dVr2A7X4gOg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGp1RlE2U3JjWVhFbGVYM09KVGJscVlKNmlvdksrZk83NlAxbVcxM3A4RFZY?=
 =?utf-8?B?NUVsVEJ6dFhRd1RVNHhtYTF3cXFpamVIN3h3K3BHSGNEQm5GOFJhNmsyN2tM?=
 =?utf-8?B?WUxnaHFyRmlmTnF0VGpKcTBRQXBPMjJkVFZzbGJpdWpIT282TW1pVHRuaWpi?=
 =?utf-8?B?bnljcTh6bnlWNnlYRkVtbEEzblVNeUdFZVp1c01OclpZZU9vVEUwaVFOQy96?=
 =?utf-8?B?clZlaUhnd01mMm5KSFlEMVkyVjdaU3RGVnhRVVloTjVBam1ENjZoaTU1dW9h?=
 =?utf-8?B?cVliQ1dwZXNtUjhHbkk2K2pESHQ2VEQ0ZWMwRWxLOGZyWmdxOXJUeW9ZTkQz?=
 =?utf-8?B?bUUzOEpsZDNBOUtDcDRoY013QmRhc0VQK05QSkEzOUw5N0ZWZjY0dTZtdC9R?=
 =?utf-8?B?SkdpcnJQZ0dZSFk1S29BNjgxRXhHV0xPNnJxQ2J4ZldXRCt6aGVBMkMzRjg2?=
 =?utf-8?B?SFZtZ2F2ckVDQ0ZDQSs1c2FqS2ZZVEhqUTNQVnBJOVlhTEp3bFNsS3NCSGxV?=
 =?utf-8?B?UC9Tak1BeUYrbG9KdythQkZSUTRRUGkvZ2l1Vllzc0JPYjQ2U3lsUTI2bE54?=
 =?utf-8?B?Uzd2cVZHYWo3bHNqVHUxeVR3VGlnUWZaQmNaS1NtcUk5UnpaeTRMaTJoUmxM?=
 =?utf-8?B?L1lXblpDelVsTlUwM3VwNWZ1azV3eDZIS1k1Ym91ZWpOYVlYTG5xYTkzejd5?=
 =?utf-8?B?WUtQYlJBTThRYUFKUmFZVC85L0pEUnl6YmNVM2NrQnFTc25EY1I3UmJGbFR6?=
 =?utf-8?B?N3Jzd05qcGxQZzhKd1RuN2FoS1pRUWIwR3FXWUJ0b04wZTdSUkZsbjFGZUll?=
 =?utf-8?B?dk1rNkRGa3BzRWM4S0h5bjdSNmtnbUNZYVV4WUVRczk1SmlaNDZuOGVBUy9L?=
 =?utf-8?B?ZVhWb1BPM0tZVXBxeUc0SWUvSHBWM3I4TWZsV2JGTUdpOGJDMmkrLzNZeXFI?=
 =?utf-8?B?V0RLcE9tdlZaS0dTMjZGNWFiUjRCVkdYbStRMUhWcTcxeFFwNVJkUDZiQjRj?=
 =?utf-8?B?VkZQV2ZrUFdMcStJd2Y3YitJT1ljRDlMdWpUSDk1UlRYV1Nod3Fra0dRWk00?=
 =?utf-8?B?engwV1BBMTJEVWd4NUtWZEw4aHdGSmt3STU5S1RKMlgyQTk3V3ZzYWoyK0Nj?=
 =?utf-8?B?THNQMUlvQnJod0I1dldHYWFlaTRKQ1oyZkpLN2pLR3FJbStiY2pCRmZQdDN6?=
 =?utf-8?B?QmFmcng4UUdld05BZEdZQTNHUmtjMDRtN3VrUUE1RGprZ0czdW9mNzhXelRT?=
 =?utf-8?B?WExkOTVrcGpVN1Q2cG4yWjZxVHhBclU5STJjcnQwc3BJb2wyWFhndDg5VlRH?=
 =?utf-8?B?UmxFNERHb0ZoVUMrNTRPQWc3NDJhK0kyaUZVQmJjUElTZHQ1WEsvOGJhblFt?=
 =?utf-8?B?ZCtsVDJoWXMzK0Z5UE1zR2dlbGpIM1ZjQXREMThYWk1manh2NDJNelJscEIz?=
 =?utf-8?B?Rm8xZVhrZm0wUmVkSUVIV1BjSW9tbFE2WHhkY0ExMmppaUM2SHRsbHY0RVlw?=
 =?utf-8?B?T3h0SWo3NmZnQklCTjdhdkNxeGRnNEdtMVJxY0xRKzB0SGFTeHJ5ejVYZDJS?=
 =?utf-8?B?V1lxMEtwanROTzFWQzJBQTBCL1J1b3NJb3Zmb3YvcG5xQ2RINDJGNFllY3ZS?=
 =?utf-8?B?YnRLbldoNzVSdExTMmJXTitwaXEyTU5reVJRSFBXT3RaaE1GbHo4TVpsK0Jj?=
 =?utf-8?B?WlVXdThyb29WRlY1MDFLbGhjNVIwM2FaWnNIeWdic29WNjlnV3IvTVg1TXVm?=
 =?utf-8?B?TUZhOCtsTWg1dHdrMHd2T2RkYzVTWERQQ0tmU01MS0dHMFEvMXQ5cFFRZ2lx?=
 =?utf-8?B?czR5QmYyZ3UzTEhSN0FreFlFT3dZZWRiWnZUZzJRNEo2Q1FOU284OGpIc29Y?=
 =?utf-8?B?NmFycHdMbk9EVkhVL2tvTXZZUHhWcFFObTRhTjFVZUtlaktESVplRDBYcjBX?=
 =?utf-8?B?dnlCaXFrZnhzanJZUlIrUEIvVTJndFNva3Q5aUVLdXd3a1FFL3lYWkM5L2ZK?=
 =?utf-8?B?SDEweWVXODFSZXVod2tOUlJlTUp0a3ViVkRIcTVYSjFKWXRqMUpOL0xVWjV0?=
 =?utf-8?B?dXhpd29pOXQ5aEJUL0JaNjIrQWh6YWtYNytBb0l3Vm9VbG1lTHBwQzFHc1A5?=
 =?utf-8?Q?lPvml3Ga9Sz0AbBSWAcNRAzPa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RQpVY6TA2nSb6GCZ1ZlDyzFkYK1DCKszQBKW1ibdK9Xn5IR/KwJirodntro+cnHjQoUz6YP8wkg+wNr19b0zrOfYlF36q3QA5z8q++k7VPX9XYCrdirl4poWzsX0NDuijZnESn9mDF362ToopXiR5yhl8AEOUXcc41bEi/fYD9wM6cIOwy7iRC8I6P/5o9MzxI8/g3kJseSEQgmUBLxJ8Pit0Tur1HeseoB04yAY2wmJk9q9oo0X4TYd/AB40Kbu00ZQocqmHRCqhpeK+37YGOaDcWiMkWT83nyXTG9538QPe8wcOyGDKdeB9i6xOtVz6y2XWitcaWBzybNQqYmzPWwpgpmRImyPsdKwo0n8s3tjvKkVBOEWoABSq2rdZbECSd4Kd5bcnggUedwMRnTHEsRtk8RtxRIq3/wNuGVV/FQ9bWD2L6fX+nlJSn5OZ+3L8jQOmBCuvrOWvENP6sn4X0CMJIpfclrlWqz5hKtnVS3RlWcaoiGTbCfMHFcCL3hAEwBixbzyL0+X7aHV+tSvbk1eAjSRTiqjN+/dj20Wzuc+7nd19V6fTo4InrPfaDTwv3Gnkw89PqTEuX0LqivhA7OR1Vi4OhZ2ktXL4AQjmwA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd63ef72-0d2e-48db-0933-08ddb322993e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:25:34.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRzTKXsVluX0cKywnwsHAnk5xbInCPDtMpoUgDxEkMBNeEg4sQCOhC0wqGFYRvrCJm8WnVD64SD4Q32yb5SmxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240113
X-Authority-Analysis: v=2.4 cv=IcWHWXqa c=1 sm=1 tr=0 ts=685aa753 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7ZIXepkyh-VqiltsLZkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0aMYN0tb4Vvr-xtCJz5TZEBhUWsa70dL
X-Proofpoint-GUID: 0aMYN0tb4Vvr-xtCJz5TZEBhUWsa70dL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExMiBTYWx0ZWRfX4H6icbRQqsmI FCeafc3LntQyZyp1SmKySh8mmpFp3cU3aRXnvQJKf1zbGkAY5lnQQCXwNPAqpYUEyytCyv+vB/m 62s8eKJhwoM0A782Ju6rX37eyzj7zKymoiFy95sRcZ5QR8HRM5FslAC2m9yotw4KINub8Je9eny
 GjDnhhLrz69WgRR7Ka8k4eoJqc7DPAuKjClI9Guu6gPsW2y8K1jr0HpqXvSAhjs3a+eM88jRQYV R/ETqE0qZAjUe9BVKQzNe33yO+6z6aR9r2Q6xEILWWkzmWBVfr7jLOxbX21k23vwK3nps5VGXlq xaU3IL7ItWi20fwzmsNqiBAl651es7gwaM65Y7mk/fXeZFpjHe1rzzB01zobCW93eAjp2AdTRxz
 RtKEfT4y9GYephBlSNFnApDEbkcOn9IoH/4wrbSYV6Qll2Vzrz7X5SzEVtOOULlGRkZHgSOo

On 24/06/2025 13:52, Christoph Hellwig wrote:
> virt_boundary_mask implies an unlimited max_segment_size.  Setting both
> can lead to data corruption because __blk_rq_map_sg() can split requests
> so that the virt_boundary_mask is not respected if max_segment_size is
> not UINT_MAX.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Hannes Reinecke<hare@suse.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>

