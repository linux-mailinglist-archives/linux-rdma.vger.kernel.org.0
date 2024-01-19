Return-Path: <linux-rdma+bounces-663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF48E832C12
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jan 2024 16:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFFE28284C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jan 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A37D54656;
	Fri, 19 Jan 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jYHXIcsD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iLwKDfKZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5E54BC5
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jan 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676680; cv=fail; b=Msx2A13Rd5pC2wurNUGjegt9mE8mMF180a3hNu2vSw3MqDpkyEHvTd2qtYb+SlA1mKqkpK1s63S1TxZ6w/C/4ada2EDJIZ+nRi741QuoBNt5T2otJQgIfWhXtmT3yc+vKn3M5811HbIlfo2K3eZyefSJvQCD6559JgURKMIoIhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676680; c=relaxed/simple;
	bh=kNAei933kE5W+4E8MSE1HFljJCQKSzZgqwACaD3V79s=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czm6BcY2zS1JZa7dJrcPtSHZPjZJ+j4VOaiaHQb2U3kwguVGU7t/TFrybO+E2FdlbE7Eyn+zKiLyDWAaFwaL51Lp2AiHyTrURIcE9WfqHGu+Dk1hXnwhSzQ+MfNbKb3VsV4zPYCCtyHhsXk/YUsLGBfFuRh/eQUpJiHch/sENYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jYHXIcsD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iLwKDfKZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JDeFkg003270
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jan 2024 15:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uOTGO7f2MW+5pvO8kmF+yUZ9R1qHMgrfP3+Q2VGg388=;
 b=jYHXIcsDZbrIwbP5X0jBA303CWO2m36OlPpvi50zUITrgPu6thuCUiAosooHFBHKkT7L
 eE1ivYJqzu/cJCgCDkk9LC5s0V62XYIfLc1B3pVPfUyWV4KjIpdLAjyFKmLBOAnOzBgH
 W/3Ic1srGKi2dbS+/Hf2bGHuqUOdc1xrhDOmPRd/Mblt3VAU0SQjvWqnFDA/RT4SKfjp
 656JmpqvPrYMzYUiZmYExKroHX8/U3IuBRuTVQavAwtFwdcvFgnpHrqghYP9khiOvpj1
 vf33FOGrOcuS6wa6/jGuhhPcEOHBTZeHfhZ7qO5McALdBe4UU1aUbpyEHSvvkIL2yEqs Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vqt5v06nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jan 2024 15:04:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40JEIVYN035953
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jan 2024 15:04:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyfehmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jan 2024 15:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMBBJucECqJ+2SA6/sdFSqsTaPFU5kOufLCPz43PH5//RnZ/33VHhuLuX5wDDvuGNxtqeHC2N9qPbzo+zXLoPITCS5gQkDVP129Cmywv2Mpl1TU1Yq+PmA7x7xnYQpd3oKmhf5PVAr/fWG0ZEdenq06XGjaJf4PVabpiLg0/WNjV/T1JcGASQGFm1xlW7m3T3b37i3HyVFuqH2Jlgns5bSHDhGGHOfkqVnwKF1iPPqtLLbHkERFBGbhR30wSWleaW4si1ngNzKZ1y3pyXv7BeQQFu8/XwyOjh+qDY8VYr5gBFg3JKFZjELCUZe6lMKHxEr89NFMeA1JPcN8fIgg9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOTGO7f2MW+5pvO8kmF+yUZ9R1qHMgrfP3+Q2VGg388=;
 b=VpVtgwlHr5XTS/ik4ksLjr5xJCMNwCJ05YjgvzXTsgvZkzv1EAEsVPDJdCiUNluzzOBKRRJpo9njJdrMi44vOVI230d8YiFl+QFzgF+G9MD2hTmyXvZhZq1zLxFZZk9FK63HbvwYNQZfdKnjTE+FdBJ9d9lNCf9B/Qpurd1ip5z4dcreEnzyYILuSFCNjKpjTj18Cq1Ci07vUI7igxukvC9SQWC6XbZtu9n8gPmCkqUtbXBVAnnB3Vl4EdnPPNCV1GGkN2hX0ihJBmTyPdbxIALcf8hl1zChbQHQyY+JJ0LqC2McQgV7U74FkNT6pl4qEsn9gRPsJgf0ZyoW7Y37gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOTGO7f2MW+5pvO8kmF+yUZ9R1qHMgrfP3+Q2VGg388=;
 b=iLwKDfKZ5zKRWu2OwTFOMqOcZLPdq69CZmRkPC1i6mOZQbY4Xamoe7mQ6y7jxAWruMQfY+zNnoVb0/3OfJhN/DUiESPuq3tzQ7HFHrll8hW7EmGI+EJG40rG4vlSCKb/JUnrhKu/p55pUHptybN8mnzr0GiEXgPeacDQbA3yblI=
Received: from CO6PR10MB5634.namprd10.prod.outlook.com (2603:10b6:303:149::17)
 by DM8PR10MB5400.namprd10.prod.outlook.com (2603:10b6:8:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 15:04:27 +0000
Received: from CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::b4df:a313:3cfb:41c5]) by CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::b4df:a313:3cfb:41c5%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 15:04:27 +0000
Message-ID: <ff776116-d019-4077-a200-9cad76cbc84d@oracle.com>
Date: Fri, 19 Jan 2024 10:04:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ibacm address config file is no longer generated by service
Content-Language: en-US
From: Mark Haywood <mark.haywood@oracle.com>
To: linux-rdma@vger.kernel.org
References: <1ad5dadb-f6c6-40cf-83cf-f269233d8cfd@oracle.com>
In-Reply-To: <1ad5dadb-f6c6-40cf-83cf-f269233d8cfd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:408:e6::6) To CO6PR10MB5634.namprd10.prod.outlook.com
 (2603:10b6:303:149::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5634:EE_|DM8PR10MB5400:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be8e7ae-26da-4057-3f59-08dc18ffee12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EEoJd//mLiycWHq9UGt4YzmkBc4XynV56xHiOftdDnHaOtkjk+mkO5mph765ZoJS205EBpMDNZH6F36G021jErbYjuRVs6CW2kwLEszMZOpWQPqWyqaNiuZm0OtpHZm6EJ/Tfkehj+67+bfnFDnunXHhwjYeiRt5YK1zvWXBtXv2XdEsj08CIlpzhpQkmCtMxXNoVWSgMjgtFPuU0m4pp/zHjumkuDIMX6Arfk3A/7ybcyGfXsOAYUx9NjlA9QOWXMcagq+dmjmIBmClQdAePmvbtlu3nKui8zKh3lsmxnDLOb0hwnYkXtEjSsTW4PmeXiprq1+wtPHTBUwaGjGXanIKVBuLG/LkRCtcI1L9QisIH88rdQHFoKsFRmysWKiK0bcToXL1+8NXY8Q60q9FYNDPoTis0Bw/w0K9W0chtmCRbyo+83kCKq/eqsZ0WCR4Q8ArM57ahOKB2BrlQOcecPCmYCQf2FOqcTDdsCsgvn3BJKyihbXJnu+cFDIPZrL4wgqna5WvxpXrdItiyvkXcX2+FzUsa60Zqc3pTUcLUWywJiGz2L6fkMw480CCEKdpfmBTZ55bqmo8fPBBkA9m9oNnRRQeroNGD1tUCIaswK5t3DDAQFPwmFPTi1eGGGEigAo79pbfmF12tnve7JoT8A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6512007)(6506007)(26005)(2616005)(6666004)(53546011)(83380400001)(316002)(44832011)(86362001)(6916009)(8676002)(8936002)(6486002)(31696002)(966005)(478600001)(66946007)(66476007)(66556008)(38100700002)(31686004)(41300700001)(36756003)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0xaeTZmNEJTQytaNnFTeXd2eUQvL3dmZXRoRHBMMFVLWGJzaktMMHE1aE5U?=
 =?utf-8?B?N0hsUzQzZTNRTE9XTlh6SWFleVhCT0RPTmVQSC9jbVVtMVdiNjFIdjlodzdX?=
 =?utf-8?B?Ukg5YWoxbHUrZlNiclZtVDV3NlFJdjh2ZlVPSEtkTHlBSnZjNlA4dE5jU1lr?=
 =?utf-8?B?QW5PS0luU0RoSEswMlQyQUxxMkNMbUtqejJnTUFKdmhEdERqUGhHUkRXZ1Ex?=
 =?utf-8?B?bjVnMjZCZVBzdGp4NGhpSGpES25nRGYzOE9iVmxCTXNpdWdwUUNWOVk0ZEJ3?=
 =?utf-8?B?bnhHQnkrdzM2VERtaHVLekdRalRKWUFDWHZYSVFvVHNxVFM1anlNd3o4STJ0?=
 =?utf-8?B?bVhaOHlnVGhXOHdkMURTWFBBRWd2TXlCWHVkM2JHMTZJRk1KcmxaQnVHZU9q?=
 =?utf-8?B?Tk1CVm9aYUFXajZoTEg1eHZsLzJvOXM1SGdOeTI4RkI3RTI3ZkFSNWdCcEhx?=
 =?utf-8?B?V1g0enF3VmFQVU9VYlhHejY1MlRTOUNQK3g4akNuN1dXdnMxMFUxbTB4OXBo?=
 =?utf-8?B?SCtzclZrZGdhMnEzSDYxWWdWOURLWk0zall3NE1XMk8xWFUrYkhtRnRiOFd0?=
 =?utf-8?B?WTlQVit6bWNrSzVweVJJaVBPSXUyb3ArUlNaZnUyWmI2MGhhQlpDeXlnTDAr?=
 =?utf-8?B?eWYyanNmcTNQTmRsTWNzYjJqeXBIZXlxLzk5TmpzSk55bmxqNERyZy9kaTZN?=
 =?utf-8?B?a0hwRG4xV1lwVEZRSWg0ZTN5U3dKUS9taVdPb2RPSTZmeHArK0tNYXpITjRw?=
 =?utf-8?B?NFpoV1lqckZqMzB6UUF6bW5tV01sWHJxMHd4SU1SRUdxL1d6WlNnemhrMXdJ?=
 =?utf-8?B?K1RvNVRNOGgvcWhlUkdyeWJkTWxneVBFWStyMzJxTmh2NlFISEM3VDZUb0lq?=
 =?utf-8?B?VzFIUVFZb0hHbjVsTW5HUDVFN1lOMlBYbGgxYWNmUURmTzVwRHdmU0lIZmE5?=
 =?utf-8?B?Y1J6ejdMK0lvcC9rbzFtV1BnT1RRVEEvVHgwQzBHaTdZYXJZRjBxbzFYWWhE?=
 =?utf-8?B?dk1NZ2NnUmd5a21qdWh2cFdwWG1KcklwellOWmRLc1V5V1lXTGg4enhsUlFN?=
 =?utf-8?B?cTkxemtpS0NZQmRDSTlhbHRHYXZ3NUticVd6b2NHZ3p5cms4QmphK0pMSVhi?=
 =?utf-8?B?WlBWU3JvdzQyVi80U1lJVUJjSm9XakhMYXVvRnBQOUk1SzEzMERnREE4Z3ZJ?=
 =?utf-8?B?UFJWbWxmYXdnMnlPVHloZHQxbTI0dGhQR1QxZTFrSG0wd21DZXk0K3FIb2pO?=
 =?utf-8?B?MHd1Z1RzVUtuZVlqYndUbytoV2w0bjNUNnpJbzQ2S2s0eFU0aU80dXN4TDZ2?=
 =?utf-8?B?YThmMWp1U0RleDNvb05sSUFqRWgvVE02c2k0MmxRbnc0dEM0NGZRR21LWmcr?=
 =?utf-8?B?WVgwMXczUHFqVURhOW5FVCs3TGpjd0RsVFh4cXJ0M3dLelFncW5wa3I0d09L?=
 =?utf-8?B?YlYvUnZ0ekNCa3luMTY4NzM4aWQzSTREcFhiNUVLdGE2TGo5SUxiRlJoYlNp?=
 =?utf-8?B?aTBZNGFOSUw2NWYvOXNoMmE2NDAwVmlMUVlJc3FEai9RNk5lRzdGQSs4RGg4?=
 =?utf-8?B?MUpiemlQS29CMnBiT0tpL0gxTlJVVDlLTlhxdkpHR1U5L0lsOGtXRzJQVS9Y?=
 =?utf-8?B?bFdlUGhLaGZTT2FWV0pBb1cwWTRxanpXWmpFckJaektlRHpuOVlvN3V1cHJ0?=
 =?utf-8?B?a2FaNGNlbVA0RGcrUng2NkRXZG1yQVUwekFoakRtbldTYlo4ODNWNytGR25Y?=
 =?utf-8?B?M3Y4ZDR4TjFCVnB6VVIzdUFQSGhnSGNMaENaK3dzdERraDE2WVRpZWQvTER4?=
 =?utf-8?B?b1ZsUW9vcUl6K203eVVpRHRJMXNNTHZqZHNOTnhtWGZTOS9Lc1I5T3YrUXZh?=
 =?utf-8?B?ZEttUFRFNHFiZG02Y1M5L1MraHFsTzlUckd2aFhqZ2gzKzhNazhVaWpRNDEw?=
 =?utf-8?B?SnJwWDJoYTMrdTI1Z3VwVFVINGZESWxjY05TODJ4dzhZb3E2Mkt0TFJ2eUFr?=
 =?utf-8?B?cnVuRUNOdlFYbVpFRVFyNmhuZVNkV215Y1dzNG9SVEFmVFFFLzNsOWphSmdE?=
 =?utf-8?B?Y0UzWktkbUhIdWVVOTZ6emhHR3pmK1BLK1NoSFFPdVd4dFBtd3JMYmJLNzh3?=
 =?utf-8?Q?1NdG/HblgVtLsBLvHlqVVftzz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yRSYKyEWM5xuzPjPEdA7JIvqoKiIj0FfNEPp1HR/lRVxWm/IPz1y0ZwCf/ct5pP6slsi0DyUPVPWmkEMroYnUb73GuFYj3dYvCqfpFAfCH5Qvmu8W+rUWpyAYOvkimhjw9a/lcZd7UN7kBdMXSI8cl91I3oVDp78i1KRXnI0MqBnc9ZD4ZfZAXOH96JYP04KWhYQ0VATHgjPW7ubtWSBA4TyyC+nIkdNVVn3uAoq/xsjO1PAYvmtl8XtdSL8kByC0cSuQiIYwvnsdTVZLjmy6bE8M5dAF39CgqwHVHPUll/pW+MG+VfuxJrysnOzilsWozMBIfeMp0Wm3RWy9B4nlvO23s3CeKolkVJbRDJFeBhghaVkbh7a2HnlWYMWZCzRXNzFLOe77W5plbX6Z6W5I+IhDelvwT5dH4f0OSVQ9G4PaXLQIPvu199Y8s0XAPa12rWFyHwG5Om5aXQ+6I7eubLpiarUjpw4Jvao5gOzhGbeiOUk71i9xwCjo5ahEXms7pJXcNVrutQWeEByyuiWk16p1lcF6E3YtXcoKXV5YHM4olCEJbLY0CjstcqxjSMwVMjSbh1oJbHr5EnbJXQ0+m4QSsnfzRfpkztfy6Tx/6w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be8e7ae-26da-4057-3f59-08dc18ffee12
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 15:04:27.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsAZoHi8fRTaBRRO2ui9V7flBM5DHN8dSWb6xPOMSiuR2D9YRRkG8vu2SaHlDViGPR365+LU09KPYAc8e2IVjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_08,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401190082
X-Proofpoint-ORIG-GUID: roHcOEeWzc9kOvbc2Vg9Y05KyNtMVxyq
X-Proofpoint-GUID: roHcOEeWzc9kOvbc2Vg9Y05KyNtMVxyq

Fixed the subject line.

On 1/18/24 4:54 PM, Mark Haywood wrote:
> I see that the ibacm address configuration file,
> /etc/rdma/ibacm_addr.cfg, is no longer generated by the ibacm service.
> This change in behavior occurred as a result of service hardening
> implemented by patch 
> https://github.com/linux-rdma/rdma-core/commit/c719619aaa0ec2651edc4e5dee9f5ff81208b185.
> 
> The patch hardened the ibacm service by adding the following options to
> ibacm.service:
> 
>  > ProtectSystem=full
>  > ProtectHome=true
>  > ProtectHostname=true
>  > ProtectKernelLogs=true
> 
> ProtectSystem=full setting makes /etc read-only for processes invoked by
> the ibacm service.
> 
> As a result, the code that generates the address configuration file (if
> it does not exist) fails:
> 
> static FILE *acm_open_addr_file(void)
> {
>          FILE *f;
> 
>          if ((f = fopen(addr_file, "r")))
>                   return f;
> 
>          acm_log(0, "notice - generating %s file\n", addr_file);
>          if (!(f = popen(acme, "r"))) {
>                  acm_log(0, "ERROR - cannot generate %s\n", addr_file);
>                  return NULL;
>          }
> 
>          pclose(f);
>          return fopen(addr_file, "r");
> }
> 
> The popen() code above is supposed to generate the file if it does not
> exist (i.e., fails the first fopen()). The popen() now fails as a result
> of the ProtectSystem option setting.
> 
> ibacm(8) does say "If the address file cannot be found, the ibacm
> service will attempt to create one using default values."
> 
> I guess my question is simply was this change in behavior expected? Are
> admins expected to run ib_acme to generate the address configuration
> file prior to starting the ibacm service?
> 
> Is the popen() code in acm_open_addr_file() being left in place in case
> an admin decides to remove the ProtectSystem option from the
> ibacm.service file?
> 
> Sorry if there was discussion around this previously that I missed.
> 
> Thanks.
> Mark
> 

