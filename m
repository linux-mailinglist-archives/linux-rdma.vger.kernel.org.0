Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363B33B3887
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 23:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhFXVXj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 17:23:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54868 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232029AbhFXVXj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 17:23:39 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OLGgN5027829;
        Thu, 24 Jun 2021 21:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sRRZqTjka8OetEokSBNp+K9vZK+HpUVIvRVxfBNKEiY=;
 b=xWo+AqTVWDbr/CYiZFcm46pMQcdW9PdWYYcQAiZPVqEg7usccS1CovAksr1aHcHytrXI
 LXMXLldvIcPGnud+BRv5ZKM0kdVPj7bVMBKGA1lZrj/7pmnDCiq6HKs3VHbSxF8fIdWN
 KYY7mKX983s0ukJWx8Mm7myQQ4LFNEh/YDGKNP/SiieqJ+ihxmPWbSrvVoj/BW9K3ATu
 Z/cvHC6ZmX6tWK9RmNQjQf0xTJEbB7p1+oSrH8ElesNymKWIjNfmE5BFk52nC2OWYAe5
 bNdPtv/bpenIEbKvGcWQPc1osGPW6gvelqLmK/yt9O7N/GNZ+E906kNsI37/74FVL/td 3w== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39c634upw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 21:21:18 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15OLIvQr190828;
        Thu, 24 Jun 2021 21:21:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 3998db2nuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 21:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6PJOkEcL3XQ/jMH2zTr45itdYA7jFUUiIbxuqhWUp116ROHYX6/pErBd85FSUSts2cd+Hbv0znFmA3Utc/mh0D9io3R5xSQ4emkQrN9JJw+aYcLiphuCOASLCDQPV9a0Hgiv6eX2IAdpNnneAuc5FEkfgSRGQntN9NlSrdQbCTjb4pM4lIpCgl9uwsNGDcAgNYZmb1NhaNMcFeVMLHqenqx5F5j2oYPsJZ+AMxKOQTKf2Z24kAwUbSfzr51g5k8+tF8BxwyULLDhoKf6lwxc5Oru2Nldo0nwUzP5HYnd9n+I5Z0EmOCjIVKJWbjiiRx18dmNhiqqvcKMLL+GOPmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRRZqTjka8OetEokSBNp+K9vZK+HpUVIvRVxfBNKEiY=;
 b=IW0d651j/KbG5szxns/UDJgGd9l6hTv3q8DFXKv3C/KLKcg4LS9MMnIKYBm1JuSpK0tbr76zDBJ9mn63j18IgPgpCLWwk18w4p5Ao9Zrg82T94BNSCVJW51bXYjpL4FoZCvNf7ghf1pRfromFu5CBKGJx3/4005NA51QuT8D5W8tn6OgaIIERmaMspCBhpGsEp3fdP5KS8PYQxMipe9iihR9f6S3crRkaj8oCbXxgDHYt5xxjgHTg9g4eGQWBTp+IuPp6k+HIk8kQ7ggQNZfExnAWsfTqFuOgZu47bOxlA5k9DH02KHD6x5Lt8JgqOxHK6Zu9i+LxwmE3om0BGFAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRRZqTjka8OetEokSBNp+K9vZK+HpUVIvRVxfBNKEiY=;
 b=KsxaCvGveo4UYxmaPvSWLDKZFx/VTGoVlseJQh9m8UjdCXoJ0Mb8KavJCkLLQhikpUJT8D5TaFKaf0N3ec2oA47SHyYTyd7Kny+/Tk8gHqz25kMFDu2um4j4+0ZvrAWg4Is6OIkvWzHm32iWFudzhtYfAyTHyenW8BaEdJJ7lPc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 24 Jun
 2021 21:21:13 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd%3]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 21:21:13 +0000
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
To:     Jason Gunthorpe <jgg@ziepe.ca>, Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
 <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
 <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
 <edcf0cc0-4da8-5af3-3366-220b4eeba5e4@gmail.com>
 <20210618163359.GA1096940@ziepe.ca>
 <14e2c2a4-6067-c657-6ea4-91cd3c19d032@gmail.com>
 <20210618232535.GB1096940@ziepe.ca>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <9b651595-94b1-4ecd-1e37-16459530f297@oracle.com>
Date:   Thu, 24 Jun 2021 14:21:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210618232535.GB1096940@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:744d:8000::233] (2606:b400:8301:1010::16aa) by BYAPR11CA0048.namprd11.prod.outlook.com (2603:10b6:a03:80::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 21:21:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0980b813-e71b-4fe2-5286-08d93755feba
X-MS-TrafficTypeDiagnostic: BY5PR10MB4161:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4161FB8E0611642DCC7785BEEF079@BY5PR10MB4161.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hiqo1mfMncX+cb4G8M12Zhvf7IGN1BBiG+ZhaZF8izxBCtBsA5HjEF1LKimZvu7vbMPrImh0ttIvU5B5P/4M5zqJlvoJon3tDF2cZJxAWocHqZsYuQ/8v9WRhsqtyfJtABbjryO566RXCC1kwS2dDYGgEZG87SRqWzzSo60obcOb5aEXPONQzIEYi7vcpUBiKjv3Hd5HEmOT5VlozEBZ6xiNfVC3Awf4tnigu2WRWT53enV9RYdBfEnl+hC7X5XrPUSBgdmC35FA5K1oOQHYAXxWq3eM+huKnN/naNrqbTF8H1j9BzVfVAyKxnU703GRCdLB0msHNlO/lW19gi6SYefUJcSG0fCHUuQMlD1G9tHZlW3b4KGU6i3KcHYLLxGZPtoPndeD9EnbtPMn7RaflxtV3hVXqX5WxwsOGQXm/nwItAXC3g68W3Z4zY0ZhLtASeZzf3ctZeJsISa8iLGVhFcJ6nddDEG3j/ofqOI4dTKxP7b1iNHGY5lkvDdmiV4PbpLcHEa2HtfS7bzl7qRDJ7g8ALaIHJ1ShDfjErAJL4wMeBkCy7e4lf0Z1FGucPqDxYOAGiaWIK41OBEf6hsA9Dk17v2XdUml+HGiHKtr1St6hQahk2YkWrfBH0TRzIrw511MKzT9m/akD1JlXaILDgGDSdCggAxcA13/L2cjMO4L7Tb6YelWfNaAFkabH5O4Ea/eg1Htf0D7rOoXKjcWsYbUlRHLDTR6edbly9CfQpUFH1kVwyt+DWrhl1jZ7dww
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(136003)(396003)(110136005)(8936002)(86362001)(2906002)(6486002)(8676002)(31686004)(4326008)(36756003)(4744005)(16526019)(83380400001)(316002)(66556008)(478600001)(5660300002)(2616005)(38100700002)(66946007)(31696002)(53546011)(186003)(66476007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NEVHhMeFFKVEM0MEtCWUozdzl2L0ZxcU45QkgzSWp5ME5yNlBnTFlNUTJV?=
 =?utf-8?B?cHBVeXk1NWxScUVXQVFMbDFhOUE3d01FU1l1V1ZSZVNsS2pPRTU0czVpejlt?=
 =?utf-8?B?b0drSDBFZUFxdm56eTFTbUY4Tng5a3d4MC9LZHYrbVNuenJ0NWdOa0ZTbm5H?=
 =?utf-8?B?YXZlLzRTTDlsSXRMeTNrZ3dvbTI1dUY3RkJrSUR4U012RmJJQVlMVG5ad2FE?=
 =?utf-8?B?bEhUM2tGYzY2WE1BR2M5aGxTUkRVSzFvclJtUVdhdDN0V1VwQWZoRVIzcnJw?=
 =?utf-8?B?clA2ZmEvN1R4NHgxS0VkRzBHQmE0b1F6NmVrazBlRGNnT3Y5SHZldVlmR1pI?=
 =?utf-8?B?SEwvb0hpd3ZGTDJBTEt2d3ZQWmc4WnRIQUxGUjgrMnVycGJENitVeGVkazFO?=
 =?utf-8?B?Tjd5YW5aaXgzRFd2QXIwRjdwU0QrVE04U3VVVlFjUWdQZkRXZkdXVzc1VkJN?=
 =?utf-8?B?bGlCbVI5clF1Nm1XdGRjK0R2R1B2b1FGSmUvRWp4NnhXRm1NSjBBZHBVRHdR?=
 =?utf-8?B?TVlydUd6OXJJM0FDTkkxcG1BbmxzdlEwYjRnUjNCSDdDQjVrWTZNN1NKZUYv?=
 =?utf-8?B?eWhYdSs2K3ZEckoyZnE5SldTVGQ1bXZHRTRCUTJGR0tlcXdsdWtMMmU5bVJL?=
 =?utf-8?B?ZFNJUTJoRjV0M2hZUXlUa2NrMkdmeEdIbEpvVjU0WUU1T3g1OVdJcXlRV0Jj?=
 =?utf-8?B?cXBRdFNQTnIrczJoTHlNNnZId3pDVVZBWXJzcXBDOWsyMXNiUDYydzN1SXgv?=
 =?utf-8?B?QWJ2Yld6TU5mV3FEYS9Xc2htTGc0Q1N1M1FER3lmWlB5MjdDL2J1aFhBcGUz?=
 =?utf-8?B?NGJNcCtYSUFNR3BYM1NXRnZ6T0F3MFRUUjlFREJiTzEwZzdMY1p3OUNPc0pY?=
 =?utf-8?B?VTh4b0NieFRlallxSG1MM0xORFFLVXpWRUhOcWVLL2ZLODFubGRVdFhDUFRE?=
 =?utf-8?B?d2dTdGNFZGthTFNvVHluOWwwaUxmWGJURGhoTXY3TFFMR1dlbmxvSkp3SnBv?=
 =?utf-8?B?QWR0NGhtUEd2QzUwbExpQXlTL0xobGVsMHNZR20rNXFLU1BnQ21qTkZkQytq?=
 =?utf-8?B?cTNYd1pjTGgyNk12R1N5eGdYMkFOcUFnd0JsNEZTR2QxTkJsOTAyY3VBeU1G?=
 =?utf-8?B?QkdHcnl5VGhpbVlScitvOE9RaDVaRnd4b0FxS2lHY1VCSmh5V3lIUzduRkQ2?=
 =?utf-8?B?cUlBMkdRTGF3c1B6cFh3WUlqZVZyWG1IWkVsVitOQ1JaTGU4ZU41amxJd3l4?=
 =?utf-8?B?TFk2VWN0L0dKRmQ3TU5hcFNPUWFBVlg2SEhYVHBYR2dwbGZpeS9LcXdPQnBV?=
 =?utf-8?B?NU8wN2xIMXE2cWx1Tk9XdUJZUEtWWmtuMEdjR2o2ME0rY2tJSWNHamgyUFo3?=
 =?utf-8?B?SFgrNHp0MVB1Z0xMUTQ0NDlmOVluQUtPcjRnOUV2aGZOcHR4dXRrbGNGcnBr?=
 =?utf-8?B?K2VIZHlxMy9zeXQxVUxWMWZPb01vU0tJbDFtQ2RVWng1eTV5NDBmUzFZL3Zu?=
 =?utf-8?B?dkdJZXVTdys1SUZzZ082Z1lOOGVPMkRXd05VR0ZPbWZxdlRXbVR2TTVReTNT?=
 =?utf-8?B?OE5uL3RJc1lPNy9FeUg1T0lpWDFVNVZPTlVkRStLd0swc1RHT1JSVEMvK0pm?=
 =?utf-8?B?Y2V5NytOcGdzRXh3OEY5T3orTXpmem9NK1N5Y2t4Tm9PY0laY3pZQnFhZ2sv?=
 =?utf-8?B?ZTc5UUllcEJRdlZ4Zlh5TjZaaktIRWYrd0tHaEl5OFRGLzNnQjFYRnU2b2NR?=
 =?utf-8?B?VHRwbkM1dEdBaklpdi81bGpVc1M1ZWNONkRuQ3dlRkdYRjg0NXRGU3BCMWlE?=
 =?utf-8?Q?/PVKKZgmqy68LlLin4e2VJT08sUZVxMgCw//c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0980b813-e71b-4fe2-5286-08d93755feba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 21:21:13.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R+XY93x5I3KdvVQyUjquOXy5WcFFFeEX0+4tl7fQH3R4LUlTGML9rdblWEOMdqt0/I713Gev5fcRSWX4M/4dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240118
X-Proofpoint-ORIG-GUID: WkqAZVoG1JBTLLxDg9QEFdDdlqVOMM7C
X-Proofpoint-GUID: WkqAZVoG1JBTLLxDg9QEFdDdlqVOMM7C
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/18/21 4:25 PM, Jason Gunthorpe wrote:
> On Fri, Jun 18, 2021 at 01:58:48PM -0500, Bob Pearson wrote:
>> On 6/18/21 11:33 AM, Jason Gunthorpe wrote:
>>> On Thu, Jun 17, 2021 at 10:56:58PM -0500, Bob Pearson wrote:
>>>   
>>>> It isn't my call. But I am in favor of tunable parameters. -- Bob Pearson
>>> Can we just delete the concept completely?
>>>
>>> Jason
>>>
>> Not sure where you are headed here. Do you mean just lift the limits
>> all together?
> Yes.. The spec doesn't have like a UCONTEXT limit for instance, and
> real HW like mlx5 has huge reported limits anyhow.

These limits are reported via uverbs, so what do we report without 
current applications. Creating pool also requires limits but I guess we 
can use something like -1 to indicate there is no limit. I would have to 
look at all the values to see if we can implement this.

Shoaib


>
> Jason
