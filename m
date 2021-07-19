Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7033CCCE6
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 06:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhGSEXN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 00:23:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10890 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhGSEXM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Jul 2021 00:23:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16J4CLaE009010;
        Mon, 19 Jul 2021 04:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IV8CUWcudu9N3zQxVpy89WV8X4oj4BGGhNIqDJbsXLc=;
 b=ybwNhJqNQvUq/ImD2A6Svk8F5c6DBO6O6V2Ir3GRCq8m+FG71BD8i9TTl+XXqfr9eKON
 pGUpR2ulUQJN9NxJ0Uw73AxQ6hv9o7LeABws1dW5LGzQGQwNJ0hPxe9gGVLEcrvt8gct
 yWKG9p/pR+ayZsesxNuX+yv7bg6qeAMuVjNZpEUxAnvxqNXyV1txB+4LmprlKwwuMpX7
 gdByZIpUFV/Jocxvucit+F1+Kum2U2+e4yzXgxGb5xefE0Zz3/jzdmimssbYqWJI7e+R
 pL2PYj9sxMxztG412IH0op4iguH5Ffs/DrJaaDKRvAFyFjq6BGSJ74xx/WasDDGNdgAS zw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IV8CUWcudu9N3zQxVpy89WV8X4oj4BGGhNIqDJbsXLc=;
 b=kN+1LhxOV21sQZdbqodF5Pdt32Whr70xe/t6z2vy5aNCEv2W6tUgChO1f5VbkiZsYXFE
 MQUPoe4xLzDQHIwsJiX0ufrSl3gqE0QEtT7ZUmjJr77KRhP4Dc3vLZ98g4srkHzPqasj
 0173wZEXj2noq08OIwv5xyye+6Z9J60keDaqSSl1oGll72/T5QMYPaKQGZoSJszQ4B6w
 SCpH20ljLNoe23SBlhkkGOIy18WAE2F0Ch/pYbV8LhY0pk1unpoiQLQOldy7onIHIf8Y
 PxcKqjFiZMk0oht16NZdFqnsa5UicqSjU6O1z0ypNreEF0UU17K/1TVtu//I4pjuNy9M bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39vqm98eju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 04:20:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16J4BB4m074210;
        Mon, 19 Jul 2021 04:20:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 39upe7h3he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 04:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bss65uw8ylJdV5Z1q4sgMA4rhDFwNR0eh3nRVtI7eIcKNLqJN3Sq34bN8bRbsYl1BtC6J4zS9dySmOAy9Tl6WiaS126ttvGjRSv0dPD7Zx0e2s3DarzMgNQI3OVGfqziopr+RVbOgxCpVtJN2HAwQZ2AhDIz1AOqpY3kbJZZ3lR76EYGIEKlYQXB/TOazRwGvejNkkrzmB/o9qp52Bv+2FUQVsQ1HjT2+KummOkkhvURGtu9vSZxyVdtKmqeMNWYa8FIdx46JZ/xSpKm+A4LyDo/0o0/vIM7JX3o8WL1giypYE7x1Y/V9TXWS5ZcvR1cywgZYxLZcIaxDymo2WHMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV8CUWcudu9N3zQxVpy89WV8X4oj4BGGhNIqDJbsXLc=;
 b=gpEtJtoKIdHy4aB+VT02eHMLN7C/pY/fGjtS2fudKgIR0tc3tBt6XNX6jIHLNe4gZFGJ87s7hhKnfqMNAWH1i1DxwCY+cdsjx0Kv4L/plcyfGRcx8ow1+Bwi0xnqSJz7doxViDtfnS298Eb1FisUSjcKz7jh0VlKfjGF1lqFtl0OFYSnWtL9S8BvoJz7BrCPF/vYjDccQ76kH7NVVLB0QbV2eLOwQDXn80yynSgerPjTrFYsPpAKZO7M7GDqlR04yY3Mp+F7hi3ukYhWwH2cemYJ7lmL7y1Uq5GnM2uBoZrMctelJay4ZKcwTBx5W1TiM5mMxc4WFS5+Wfre088iSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV8CUWcudu9N3zQxVpy89WV8X4oj4BGGhNIqDJbsXLc=;
 b=srcu0PEa1PkYOabHruFg6+Ndev152Sg9m/OSNiY4dVByM/T7rbm+EHsnJbopL+VASi+DKlfd8y0EJkslAv0SjZ9BfJlK4OAgf9KcUr89P7jt+lzP3nJTS46fX5gAo/CgvKywIYTQzjNAw9ijIB0mOXdJ+OXOkSyhjIQ1kyn4rTI=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4260.namprd10.prod.outlook.com (2603:10b6:a03:202::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 04:20:08 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 04:20:08 +0000
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
 <20210714083516.456736-2-Rao.Shoaib@oracle.com>
 <CAD=hENdhJJghv2GNh3V7ndyoJ8eRej8g2TeoDFn6F4T+n2cTHA@mail.gmail.com>
 <1f764b55-77d4-8332-858e-fb9e8bd9abcd@oracle.com>
 <CAD=hENcEZ6MFrivYoBmbiBEcCjFbg-6yFQJ6TrLSNQVkDs+2_A@mail.gmail.com>
 <8eba2b02-36c5-e14c-3503-0e1cfeea4dd9@oracle.com>
 <CAD=hENf5an1Vz-vKUoCPwOazB4KfXMrjyZx1MgamVZo8j0HTtg@mail.gmail.com>
 <74c62daa-9f20-cb51-ff6a-fb7def78b444@oracle.com>
 <2b8a485d-d9bb-1579-613c-c32f580f3f2a@oracle.com>
 <CAD=hENccPzsoDw-5FZ1fyokiPyi66s+TkBWGsPXCMvtP+eUG=A@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <57235c86-0ed8-f75b-55ee-2a20b750340d@oracle.com>
Date:   Sun, 18 Jul 2021 21:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAD=hENccPzsoDw-5FZ1fyokiPyi66s+TkBWGsPXCMvtP+eUG=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:806:27::30) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::b3] (2606:b400:8301:1010::16aa) by SA9PR13CA0145.namprd13.prod.outlook.com (2603:10b6:806:27::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend Transport; Mon, 19 Jul 2021 04:20:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94801c6d-c2a2-47d6-1c21-08d94a6c7dcd
X-MS-TrafficTypeDiagnostic: BY5PR10MB4260:
X-Microsoft-Antispam-PRVS: <BY5PR10MB42604815E09D003D815D81A4EFE19@BY5PR10MB4260.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OF9ATEZFiD9t6DxoJ4VLKNTDAQOZboqJw7jHgyYxmRm0u+n0AjN+kxS36x7Qsq4VAo1XurOz5iFLkjPGaALmibmVQtHB50xlmylXMUrPbekWJCnD5rNJcik5dcu7YxcDKK+lw0iZyTo9b9ff6GuPHWhPlF6AMCV5QFHRQM6KXRDTsJU7lLIB72BiyiObrENuRCB+3anIv77EuZQ5NmNfTjp7e+7ugp9RpBLKe8gCujHX6tU6wgpzh2sesJXF3TycJqRDCViWyfOrvyIt1YckkgzdtJxAR6X1fbnag8QXVIwxLX/LvaIFc94/FZX2MR1GOuf+il9C5Jxx4K8gWY/Nms4+MxaLrv5HEWBc/cYUZ1+KFoZZCm2d0SzwQW1CG6mvDCpWY7U4fmc+CdsSAWgC8YWtTn6BVK3jsjnV5qqv/y024Jndgla3MNiRVCqodK+9g+5IrwLPahdRhiN6mH2TGlP5jOa1k1orJJbT+0nBmXNG6ebY2xALn1qHECNHm3YOBMCfBerKRTvnmHDRDzO5TDMyunONPe63bT1kwNAQLuCfxvpSBQCTJgq/5439hmCYoFPCgrpVqGuwM+zLaq7T8c5w2zKvrZZhyaoFQ0q33L+F7o4X1x3IHpuyYLflSASCkCsQ7iTLdMqM6XO9Aj273RvG+e93qBw+nPRlUb20dH5swzaoNqjc+dnjJXf0jkLTUmQXIYow10ozk8Vi6JqUp9snexou4/0ccMEDBBKjbaShmrhlu+URMpt1Fz6wulH6kbSDagSIQc3nhd7CvK5bWa28ozEtrvp2X16rNtzVFBpBCX0fZNt2J9JA93Sao4kg1oUpbovdbXRyZ3RqpDB0WzhW9GuX0CHmwBZ0QDb8GA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(396003)(346002)(376002)(36756003)(2616005)(31686004)(2906002)(31696002)(6916009)(316002)(54906003)(86362001)(186003)(8676002)(478600001)(53546011)(8936002)(6486002)(966005)(5660300002)(4326008)(38100700002)(66556008)(66476007)(83380400001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjBCOEN3SlpZK3NiL1plRUN2UzIzVmxLb252dEY2SlB5elE2bmd2UDVOcGo5?=
 =?utf-8?B?M3lEL2Q4REZOWk9lbVBjQXhHaGhZNVNyNE95cHA3Q0xkbnVxTkZUTi9ZQnBR?=
 =?utf-8?B?TXE4ZlJnRHd5aGphSExVbms3dFNiU05TVnI1dmsyRkhYRjRIaHRMSi9pZTlG?=
 =?utf-8?B?TG5rNnZCenF3L20vUzI4dzJoRXNzWEsyQXRMcUNqc2t6cnR3TUhHYkZYS29u?=
 =?utf-8?B?ZGlsVlV1WkhtNWpQak5zM2dkM1NBMm1TZ3kvd3JkcFdSazkwUUROa081SjRQ?=
 =?utf-8?B?WCtIZXdVdVR3ekkySkJFajNocTdibnNWZnpoZERaQUZvcWtpeVVFMk1qQ2pJ?=
 =?utf-8?B?cTRrVm9jQWFoejRJdGJnOGEyYnE2ZytpVkVmdzhObExBbEY3R1FkQUhMNTRD?=
 =?utf-8?B?ZnVXTm5tcWI1bnZyRUUwTGtaYUVQb0RzOUo0TEJSRjJkZmNXUmY2SzgzMGVS?=
 =?utf-8?B?QTZNdjhzUldFZDlSMHNBZWZPMHVuZjlXS1JpcHpVYmFnd0RWL2JjbVloMG5L?=
 =?utf-8?B?WTlkTW14MFZEekFkODZHcExMcm55UmMrQVZRMDNrbFk1MkRpSHJjZ3E0MEdq?=
 =?utf-8?B?cW5JS2Zkck50UmJueFR6NVU0dGNmQitJMFJrTHh1aTdFOFU0YkNkSTllQ05s?=
 =?utf-8?B?dGYraUQxVUw3K1V1N0x1R1BxTVVnZk5sZEtVZUNjaVNVTDlHL0VpZlVDZTlk?=
 =?utf-8?B?b2dyYzZSNStPQTV3RnlKZGFzZEZQdFVuenRwZXJjWnl4MVF0YTBnYmFmaEVk?=
 =?utf-8?B?SEQzWlJOY0krVEtVdVFDQ2NYUy9ONFY4TjBLMzAzV09PdUpkOXdLOCt6alFC?=
 =?utf-8?B?c1JDOEh5RVhsM3Z0MTlkMDJMNGozSVFUSzdXOWJXY0hzQWJGWWhnK3EzSmY0?=
 =?utf-8?B?QTRTTUZWanBldkpDb3UyeEJhaUhzbGJWbGFmSXJ4ODY0aWMzUnk0N2htSlB0?=
 =?utf-8?B?VVZHQVUwRlNKcWE1dWtYUFNiTkZPZTMrT1NIYXFrbnlKUFpCOStrczZRYit0?=
 =?utf-8?B?Vy9tekRCdzUvYWh5cFdpaVVUVFl5d1F5dW9qVUlUSDZaS1BDN2FxUTFSSVA5?=
 =?utf-8?B?WGpmTzliNmF0WkJQd0hrN2JqRFEyWStpRFdJeVJrNENBbFM1Mk5QTVFZc2RR?=
 =?utf-8?B?QmxXSjNZVUlhTkJmQzFpSy9vOCtNWXVYTlozNGtQaDdkZDVnWlV3djVVc1k4?=
 =?utf-8?B?Zzh1cDVlV1Z1VE8vREo1NDhhTXlDUThLbVNjOEZZTExtOHNpOU42b0tVQmxh?=
 =?utf-8?B?Ym0wZ1lwNStqZTRxUjVOejNLRCtmYllVN2dZNSttZW54eFRTNGpId1RTRGEz?=
 =?utf-8?B?MFpLUVh5bWFNV01TMEhxWnVaVjZvb0N1ZTZwVDNYbUN2bUlwV3lMc3NDc25Y?=
 =?utf-8?B?ZmhXVlJHZjdGY2hrWDVyNVd1SzRyeXBKb2RqT3l5N0Vrc056UERoTGRJSHZk?=
 =?utf-8?B?NWlIeGs3eTF1RjA0K0IrLzVSNUw5Tk8veFNjaWlqZVQxUHNwdXdSK1Evdm1p?=
 =?utf-8?B?WDZPOXN0MWlmblJQSDBOTUl5Vm9mdWlqOStyaVpzSHpiMHV6RWY0ZUFtSG10?=
 =?utf-8?B?YkVrN3h5bUZJeWM3VFRVSUZKdXhOc3hzR0pCb1ZZUGRjWlFHZExpa2V1dWdN?=
 =?utf-8?B?b0JMWDVjWGluZ3VBVURZZFgwbjQ0R2Y0MzVIcE93TTU4UmlaaG5pa0RvazE2?=
 =?utf-8?B?bjMwMUJ2bDhKTDQ4VThtSGZyWGJjMklodTV5bGFQL1FoOTVBWFFReXh4WDZr?=
 =?utf-8?B?aHlBVXBHUTE5TjhzUWYwRytpU1dKWXFoQXMwNXBNWS9CaGFGSHZ3QmdkeG9s?=
 =?utf-8?Q?+gnf3yluMlthJvvmCEIpL1FqMx6RwajbIndqc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94801c6d-c2a2-47d6-1c21-08d94a6c7dcd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 04:20:07.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MOH0oLFCFcID519T36rBV5opVa5SjPbvDuf0MzzsiFfZwJ0K6WwnD4PFMUjEl2dTmRX0LpNKJFlqitrCwjbSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4260
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107190024
X-Proofpoint-GUID: Tvk9KG09TGM2I4ZaWLqQ1KL_lQ1BGpaW
X-Proofpoint-ORIG-GUID: Tvk9KG09TGM2I4ZaWLqQ1KL_lQ1BGpaW
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 7/18/21 7:25 PM, Zhu Yanjun wrote:
> On Mon, Jul 19, 2021 at 7:00 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>> Thanks for reporting the issue. I was able to reproduce the issue and
>> have fixed it. Kindly try gain.
> Do you make tests with rdma-core?
>
> IMHO, it is important to make tests with rdma-core before the commit
> is sent to the community.

Yes I did. However the issue shows up only when I configure an interface 
not just when module is loading.  Anyways, my apologies.

Shoaib

>
> Zhu Yanjun
>
>> Regards,
>>
>> Shoaib
>>
>>
>> On 7/18/21 12:46 PM, Shoaib Rao wrote:
>>> Your urls are garbled, so I can not make any sense out of them.
>>>
>>> [root@ca-dev141 linux]# git remote --v
>>> origin
>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git__;!!ACWV5N9M2RV99hQ!dGmB_LFQF6at31F0sVXbfyjtAlgNTWzBEaIER13mVG0ZAWBomLdmWXUe6DxoVFcz$
>>> (fetch)
>>> origin
>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git__;!!ACWV5N9M2RV99hQ!dGmB_LFQF6at31F0sVXbfyjtAlgNTWzBEaIER13mVG0ZAWBomLdmWXUe6DxoVFcz$  (push)
>>>
>>> [root@ca-dev141 linux]# git show 8c1b4316c3fa
>>> fatal: ambiguous argument '8c1b4316c3fa': unknown revision or path not
>>> in the working tree.
>>>
>>> [root@ca-dev141 linux]# git log --grep='RDMA/efa: Split hardware'
>>> [root@ca-dev141 linux]#
>>>
>>> [root@ca-dev141 linux]# git describe
>>> v5.14-rc1-17-gc06676b5953b
>>>
>>> You need to do a little bit more work on your end and tell me which
>>> value rxe is complaining about. Also provide a kernel version that you
>>> are using as I have provided above.
>>>
>>> Shoaib
>>>
>>> On 7/18/21 12:59 AM, Zhu Yanjun wrote:
>>>> On Sat, Jul 17, 2021 at 2:09 AM Shoaib Rao <rao.shoaib@oracle.com>
>>>> wrote:
>>>>> On 7/15/21 9:07 PM, Zhu Yanjun wrote:
>>>>>
>>>>> On Fri, Jul 16, 2021 at 12:44 AM Shoaib Rao <rao.shoaib@oracle.com>
>>>>> wrote:
>>>>>
>>>>> Following is a link
>>>>>
>>>>> https://urldefense.com/v3/__https://marc.info/?l=linux-rdma&m=162395437604846&w=2__;!!ACWV5N9M2RV99hQ!f9TPWtgUxambtSeQ_L3h-IH7CW3SifyiumB3kjc2v_w6Ec_WYVtjWyusEtgQ60iw$
>>>>>
>>>>>
>>>>> Or just search for my name in the archive.
>>>>>
>>>>> Do you see any issues with this value?
>>>>>
>>>>> After this commit is applied, I confronted the following problem
>>>>> "
>>>>> [  639.943561] rdma_rxe: unloaded
>>>>> [  679.717143] rdma_rxe: loaded
>>>>> [  691.721055] rdma_rxe: not enough indices for max_elem
>>>>> "
>>>>> Not sure if this problem is introduced by this commit. Please help to
>>>>> check this problem.
>>>>> Thanks a lot.
>>>>>
>>>>> Zhu Yanjun
>>>>>
>>>>> I do not see the issue.
>>>>>
>>>>> [root@ca-dev66 rxe]# lsmod | grep rdma_rxe
>>>>> rdma_rxe              126976  0
>>>>> ip6_udp_tunnel         16384  1 rdma_rxe
>>>>> udp_tunnel             20480  1 rdma_rxe
>>>>> ib_uverbs             147456  3 rdma_rxe,rdma_ucm,mlx5_ib
>>>>> ib_core               364544  10
>>>>> rdma_cm,ib_ipoib,rdma_rxe,rds_rdma,iw_cm,ib_umad,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
>>>>>
>>>>> I am using gdb to dump the values
>>>>>
>>>>> (gdb) ptype RXE_MAX_INLINE_DATA
>>>>> type = enum rxe_device_param {RXE_MAX_MR_SIZE = -1,
>>>>>       RXE_PAGE_SIZE_CAP = 4294963200, RXE_MAX_QP_WR = 1048576,
>>>>>       RXE_DEVICE_CAP_FLAGS = 137466362998, RXE_MAX_SGE = 32,
>>>>>       RXE_MAX_WQE_SIZE = 720, RXE_MAX_INLINE_DATA = 512,
>>>>> RXE_MAX_SGE_RD = 32,
>>>>>       RXE_MAX_CQ = 1048576, RXE_MAX_LOG_CQE = 15, RXE_MAX_PD = 1048576,
>>>>>       RXE_MAX_QP_RD_ATOM = 128, RXE_MAX_RES_RD_ATOM = 258048,
>>>>>       RXE_MAX_QP_INIT_RD_ATOM = 128, RXE_MAX_MCAST_GRP = 8192,
>>>>>       RXE_MAX_MCAST_QP_ATTACH = 56, RXE_MAX_TOT_MCAST_QP_ATTACH =
>>>>> 458752,
>>>>>       RXE_MAX_AH = 1048576, RXE_MAX_SRQ_WR = 1048576, RXE_MIN_SRQ_WR
>>>>> = 1,
>>>>>       RXE_MAX_SRQ_SGE = 27, RXE_MIN_SRQ_SGE = 1,
>>>>>       RXE_MAX_FMR_PAGE_LIST_LEN = 512, RXE_MAX_PKEYS = 64,
>>>>>       RXE_LOCAL_CA_ACK_DELAY = 15, RXE_MAX_UCONTEXT = 1048576,
>>>>> RXE_NUM_PORT = 1,
>>>>>       RXE_MAX_QP = 1048576, RXE_MIN_QP_INDEX = 16, RXE_MAX_QP_INDEX =
>>>>> 262144,
>>>>>       RXE_MAX_SRQ = 1048576, RXE_MIN_SRQ_INDEX = 131073,
>>>>>       RXE_MAX_SRQ_INDEX = 262144, RXE_MAX_MR = 1048576, RXE_MAX_MW =
>>>>> 4096,
>>>>>       RXE_MIN_MR_INDEX = 1, RXE_MAX_MR_INDEX = 262144,
>>>>> RXE_MIN_MW_INDEX = 65537,
>>>>>       RXE_MAX_MW_INDEX = 131072, RXE_MAX_PKT_PER_ACK = 64,
>>>>>       RXE_MAX_UNACKED_PSNS = 128, RXE_INFLIGHT_SKBS_PER_QP_HIGH = 64,
>>>>>       RXE_INFLIGHT_SKBS_PER_QP_LOW = 16, RXE_NSEC_ARB_TIMER_DELAY = 200,
>>>>>       RXE_VENDOR_ID = 16777215}
>>>>>
>>>>> It is possible that you are changing some values.
>>>> I git clone the source code from
>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git__;!!ACWV5N9M2RV99hQ!efPsL9fikzm6Ob1-zsmbsAzPkfqRpxYkp9oJXF9csPOJgoei9njj8RmA5IyuH447$
>>>> again.
>>>> And the first 3 commits are as below. One is your commit.
>>>> "
>>>> 6163ad3208c8 (HEAD -> for-next) RDMA/rxe: Bump up default maximum
>>>> values used via uverbs
>>>> 8c1b4316c3fa (origin/for-next, origin/HEAD) RDMA/efa: Split hardware
>>>> stats to device and port stats
>>>> 916071185b17 MAINTAINERS: Update maintainers of HiSilicon RoCE
>>>> "
>>>>
>>>> And when I tried to add a new rxe0,
>>>> "
>>>> error: Invalid argument
>>>> "
>>>> And the dmesg logs are as below:
>>>>
>>>> # dmesg
>>>> "
>>>> [   70.782302] e1000: enp0s8 NIC Link is Up 1000 Mbps Full Duplex,
>>>> Flow Control: RX
>>>> [   70.782744] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s8: link becomes ready
>>>> [   79.467652] rdma_rxe: loaded
>>>> [   79.468348] rdma_rxe: not enough indices for max_elem
>>>> [   79.468356] rdma_rxe: failed to add enp0s8
>>>> "
>>>>
>>>> Please follow my steps to reproduce this problem again.
>>>>
>>>> Zhu Yanjun
>>>>
>>>>> Shoaib
>>>>>
>>>>> Shoaib
>>>>>
>>>>> On 7/14/21 10:02 PM, Zhu Yanjun wrote:
>>>>>
>>>>> On Wed, Jul 14, 2021 at 4:36 PM Rao Shoaib <Rao.Shoaib@oracle.com>
>>>>> wrote:
>>>>>
>>>>> From: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
>>>>>
>>>>> In our internal testing we have found that the
>>>>> current maximum are too smalls. Ideally there should
>>>>> be no limits but currently maximum values are reported
>>>>> via ibv_query_device, so we have to keep maximum values
>>>>> but they have been made suffiently large.
>>>>>
>>>>> Resubmitting after fixing an issue reported by test robot.
>>>>>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>
>>>>> Signed-off-by: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
>>>>> ---
>>>>>     drivers/infiniband/sw/rxe/rxe_param.h | 26
>>>>> ++++++++++++++------------
>>>>>     1 file changed, 14 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h
>>>>> b/drivers/infiniband/sw/rxe/rxe_param.h
>>>>> index 742e6ec93686..092dbff890f2 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>>>>> @@ -9,6 +9,8 @@
>>>>>
>>>>>     #include <uapi/rdma/rdma_user_rxe.h>
>>>>>
>>>>> +#define DEFAULT_MAX_VALUE (1 << 20)
>>>>>
>>>>> Can you let me know the link in which the above value is discussed?
>>>>>
>>>>> Thanks,
>>>>> Zhu Yanjun
>>>>>
>>>>> +
>>>>>     static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
>>>>>     {
>>>>>            if (mtu < 256)
>>>>> @@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int
>>>>> mtu)
>>>>>     enum rxe_device_param {
>>>>>            RXE_MAX_MR_SIZE                 = -1ull,
>>>>>            RXE_PAGE_SIZE_CAP               = 0xfffff000,
>>>>> -       RXE_MAX_QP_WR                   = 0x4000,
>>>>> +       RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
>>>>>            RXE_DEVICE_CAP_FLAGS            = IB_DEVICE_BAD_PKEY_CNTR
>>>>>                                            | IB_DEVICE_BAD_QKEY_CNTR
>>>>>                                            | IB_DEVICE_AUTO_PATH_MIG
>>>>> @@ -58,40 +60,40 @@ enum rxe_device_param {
>>>>>            RXE_MAX_INLINE_DATA             = RXE_MAX_WQE_SIZE -
>>>>>                                              sizeof(struct
>>>>> rxe_send_wqe),
>>>>>            RXE_MAX_SGE_RD                  = 32,
>>>>> -       RXE_MAX_CQ                      = 16384,
>>>>> +       RXE_MAX_CQ                      = DEFAULT_MAX_VALUE,
>>>>>            RXE_MAX_LOG_CQE                 = 15,
>>>>> -       RXE_MAX_PD                      = 0x7ffc,
>>>>> +       RXE_MAX_PD                      = DEFAULT_MAX_VALUE,
>>>>>            RXE_MAX_QP_RD_ATOM              = 128,
>>>>>            RXE_MAX_RES_RD_ATOM             = 0x3f000,
>>>>>            RXE_MAX_QP_INIT_RD_ATOM         = 128,
>>>>>            RXE_MAX_MCAST_GRP               = 8192,
>>>>>            RXE_MAX_MCAST_QP_ATTACH         = 56,
>>>>>            RXE_MAX_TOT_MCAST_QP_ATTACH     = 0x70000,
>>>>> -       RXE_MAX_AH                      = 100,
>>>>> -       RXE_MAX_SRQ_WR                  = 0x4000,
>>>>> +       RXE_MAX_AH                      = DEFAULT_MAX_VALUE,
>>>>> +       RXE_MAX_SRQ_WR                  = DEFAULT_MAX_VALUE,
>>>>>            RXE_MIN_SRQ_WR                  = 1,
>>>>>            RXE_MAX_SRQ_SGE                 = 27,
>>>>>            RXE_MIN_SRQ_SGE                 = 1,
>>>>>            RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
>>>>> -       RXE_MAX_PKEYS                   = 1,
>>>>> +       RXE_MAX_PKEYS                   = 64,
>>>>>            RXE_LOCAL_CA_ACK_DELAY          = 15,
>>>>>
>>>>> -       RXE_MAX_UCONTEXT                = 512,
>>>>> +       RXE_MAX_UCONTEXT                = DEFAULT_MAX_VALUE,
>>>>>
>>>>>            RXE_NUM_PORT                    = 1,
>>>>>
>>>>> -       RXE_MAX_QP                      = 0x10000,
>>>>> +       RXE_MAX_QP                      = DEFAULT_MAX_VALUE,
>>>>>            RXE_MIN_QP_INDEX                = 16,
>>>>> -       RXE_MAX_QP_INDEX                = 0x00020000,
>>>>> +       RXE_MAX_QP_INDEX                = 0x00040000,
>>>>>
>>>>> -       RXE_MAX_SRQ                     = 0x00001000,
>>>>> +       RXE_MAX_SRQ                     = DEFAULT_MAX_VALUE,
>>>>>            RXE_MIN_SRQ_INDEX               = 0x00020001,
>>>>>            RXE_MAX_SRQ_INDEX               = 0x00040000,
>>>>>
>>>>> -       RXE_MAX_MR                      = 0x00001000,
>>>>> +       RXE_MAX_MR                      = DEFAULT_MAX_VALUE,
>>>>>            RXE_MAX_MW                      = 0x00001000,
>>>>>            RXE_MIN_MR_INDEX                = 0x00000001,
>>>>> -       RXE_MAX_MR_INDEX                = 0x00010000,
>>>>> +       RXE_MAX_MR_INDEX                = 0x00040000,
>>>>>            RXE_MIN_MW_INDEX                = 0x00010001,
>>>>>            RXE_MAX_MW_INDEX                = 0x00020000,
>>>>>
>>>>> --
>>>>> 2.27.0
>>>>>
