Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A83B476A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 18:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFYQa2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 12:30:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4986 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhFYQa1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 12:30:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PGPp1C031317;
        Fri, 25 Jun 2021 16:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=F7G5okVlLHqMEsOIGZRpg0+cvNiKRLZvijCE/g8uTHM=;
 b=CFYCZtZt070ix43qBcgPr3C0eViHMGbgkWXpZxk7AtXZX4UkOSDGuzsM7HvK9YHqdHwK
 ipTEFrSuF99CgC5rEUHdJd7D3MoJzO7H2re6Av65pYSrZQFCX9GcGZnAVlYD/SWxO962
 0NriPk86fN5tYCEZudm4lZmLFeThsXlHPRw6vxR28mn4lIWWbh/xvwQOxUiaKWSINBOX
 PWU24yw+sEz9LVRbKvuJqnW8nT/pbflaayg4gmV4sL8bb4KzeoVAGcpWqVDXJEQkzlMw
 7El2dNGb8hsWgmNTnWONxulBfjxV+26i6431HNjEMGrrt4CuS7toGHREXW7NKzXqHbpm TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24m1t4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 16:28:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PGPcJC114532;
        Fri, 25 Jun 2021 16:28:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 39d243rfa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 16:28:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qux/3Z9SeQCds4kxUvaedINg8cSE06yB6sX8j+vdp9WDOO04dQgqdpc9wBL0EjIMgsrSi6vVXsdWvFQ/XkXbsTmQYRjBcK9aOpq8c/cXkng/QJSUgBr+3CRyWQ/NjAJM/xAM9F2/u+Z0ezz7EQsAkFopxfhIVbntm0uvi8W8ZPEM/tedq7iyd8A9F/8rZcr1eV6z0kO7DmFvu4S83Ww0SpP54locKEXkwREH6gQ+so87bz+S70ayv/6I3LiNlX2wgHPDkraPchoVh8EPZus/9Vp3lwfRorg2RoaTZTigLcxbuF7lY1Tdhsz4+Crsa3oY7haQFJELHo10Kkle9OF4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7G5okVlLHqMEsOIGZRpg0+cvNiKRLZvijCE/g8uTHM=;
 b=KM/62S1gG5j0RHBDHoGZvU9bADaFaM9mnUV88UpBmNlPW7yfDtR1dxTbgcveUxe4ZpUDjkZ8x3C065XlT+ilZSyCchpJ2+yB+qUR3oEKx3p/TzhkS7JHZyFdwfT0oYTvL3Pv6sXU420tBl8BJFO3XcvnuzQ7BrjQ0cKZEYt0qI0gt10kUFLNG8zK92ALXw7IE7T5jpxIE6jjiZ0q5XAyrC5xv3qiB1m51JhFOin0c3OJs5CZGBIzz6S07pmH/xuvv7fRInoJb7O2/AigWoESyEGBxX1APPpScP8MZ/D75n11MutU1IvCh7fLqxEGUCEmZhjaY+yR+aqglF2kBH236g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7G5okVlLHqMEsOIGZRpg0+cvNiKRLZvijCE/g8uTHM=;
 b=t3sJ8JMZVwUNaOYpsTxKhl3IxPf8jvkowKahCr78mPB0tF+yFDGfLlQd+EgrTo2j1Bs/W9t06f3NJ38hVWECnW8nZTxJfPw6EIHR/uVWH6FqaiJNsgJqHASwlSMIwIeBBLOkMzGPeD/GoMczs8VS+hRsVa0SJbUSGDPSuytnQbs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23)
 by BYAPR10MB3494.namprd10.prod.outlook.com (2603:10b6:a03:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 16:28:00 +0000
Received: from BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::3c6b:8429:3eb3:6559]) by BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::3c6b:8429:3eb3:6559%4]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 16:28:00 +0000
Subject: Re: [PATCH 1/1] RDMA/cma: Fix rdma_resolve_route memory leak
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
References: <f6662b7b-bdb7-2706-1e12-47c61d3474b6@oracle.com>
 <20210625150311.GA3006866@nvidia.com>
From:   Gerd Rausch <gerd.rausch@oracle.com>
Message-ID: <dabc6d03-da37-27df-833c-1851d08706e0@oracle.com>
Date:   Fri, 25 Jun 2021 09:27:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <20210625150311.GA3006866@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2405:ba00:8000:1021::1046]
X-ClientProxiedBy: SA0PR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:806:d0::34) To BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ib0.gerd.us.oracle.com (2405:ba00:8000:1021::1046) by SA0PR11CA0059.namprd11.prod.outlook.com (2603:10b6:806:d0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 16:27:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98380a80-8475-42bd-d4a0-08d937f63277
X-MS-TrafficTypeDiagnostic: BYAPR10MB3494:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3494AF594ED683FF74682FF687069@BYAPR10MB3494.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36jBLi9oY5mHP2tXelnzScUU3NQ6u7gDem4rRNufvOFY0yRv181DPUSh3X5E0bidhDMpUsVHh7LlUIzbQIQeNp2+O+WfIBDSJIcwvpsr89sbBgnof859c9wW6gc0HLWIPQTsOCT1HIipIGgl+WGILUlOt/igy6Y/B0z3Lt2ucrAfPuVMPGUDU91UQxJfFDnLlqv838QMwfdlci3laIVmYBa3P3xjwbRXsoFHzD2kQVlTMGcbj8sdNMsA5GJSll3iTz0ZfpfMk5ToT1iMLBTt5BG1bmbHLlXM3ighmE+rfBSq0OZb1m7wjzKrs1PC216ln+tZ/LE7YPzFktsolxaYb2DV+6QcC0oz87Kjf3ovyD3IApHYG8rJdThM2+IIAaQpod6zTUoDFPjvNSitTSESR6DhFJPUT5J0wiJylrAUoy5GOmP7Qu1/zM/ZR9rEEcehuBBxguTSDrv9Dn+hc3iUqUuYxydOvYKT9yS9xh9eTQX6o3uEONpO0cG8pSC89UqB3npZTWEsyLATTarOu2CEMfiFSiayoBE3x3c6ywT9Y82ILtI0b6HtcZs5XHXUWiKu2g7VmqOCX+DHH6Q/zWoD0MkwYjZZ/9DrDplxA3rop+XrfC7hC/C9fUJPhxBDEbH3R8EyulT7rE8rBHNS7QBG82FuT14gj69+bVcD/JdpMafwFTYZt0A8pAUb0RUqKOwfBvhNXVHnRNraSccn0xxM+05E5oW/hk7mb3uOB7xhbrYFBOPQd+05KOSXbEX2LLXp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(376002)(136003)(8676002)(31686004)(6916009)(52116002)(66556008)(478600001)(66476007)(6666004)(7696005)(16526019)(66946007)(5660300002)(6486002)(4744005)(316002)(186003)(83380400001)(4326008)(36756003)(2906002)(2616005)(31696002)(38100700002)(8936002)(86362001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Myd3dzZnVybFBFYUZaeTVqYjh3VFBvRTBVMFhza1ZzQVBmMDRidDJNdFph?=
 =?utf-8?B?cytTbU1vN2g3UG16U21pd0V3QnpMQ2hJeC9wRTl4ajlqanlTZ0w5bHBRZVpG?=
 =?utf-8?B?TEplR0w5ZlZVOEdSdGF4eHRTOC92NysvUzhhM0FuZC9yL243VS9mQTlWM0Zi?=
 =?utf-8?B?QjRMdFIrTy84MUt6eXVVTUdJWXNWbVRBRGs2a1FzVXg1cHdWeGZJNGFGdmhX?=
 =?utf-8?B?OUlMU3VpVDlCQzFGL3VGU2ExdXJoRXVmdkNtc3N1N1hCd3hZb2FQK29YaGZT?=
 =?utf-8?B?M1FNdEZ1RTkrN1c2akdHcURweG45TDhqL1FGdVFZQnh0bXo0VE9wYlhHV0Iy?=
 =?utf-8?B?ZHFvMWF4MHJUM3Q5L3lHVWJ0L2gwZHZLU3B4UDBpS01iZHZicWFHMnZPT0l1?=
 =?utf-8?B?UmxhU1JiK1Y0RFBJR0hRbzdpaEtKUURiR1B0amxQK3VuTzd2a3FzVXV3Y2VR?=
 =?utf-8?B?YUxLUk1IZGdvYjNoMjU2VmV5OG5rTFVzdDdOWU45SUhES3ZLbUtPeXU2aDNo?=
 =?utf-8?B?c3FTZTdEQzhQR3BDWHVGYmJ0aVMzMWtiRStHSUpNa0Rtc2tJTjhFR1BMNStL?=
 =?utf-8?B?MndLeHRtZGlmMGxCWFZmUXZPTE5LT2lOUnhib2lta296QkllZnovNWpvUVJM?=
 =?utf-8?B?UGc5SW0xSk5uM0xWV0FwOWZJcFhYQ2pjdkkrL0dpVWNBOVJvVGtyQk9MRnlq?=
 =?utf-8?B?QXhVaWtzcGg5eWpDdjRocjg5OHNzM1hkeTNoMnFLQll2M2VpaVFJSSt1a20w?=
 =?utf-8?B?VG54MFk5ZE82NWFGQk9sTHRnU2JxcHM5bldKK0N3RXl2WUZNakl1Rzh3elAv?=
 =?utf-8?B?ZUpSRExHUjkzV09sSit2bzlNQmZKUTJiNitqbE8rcVN5SkpjTFRmYW9rQWhs?=
 =?utf-8?B?Y2hBVXZnTS9SanduQngraHJCNElQWmNlNER1MVpvK3JlcllNd3JnMkN1WUZl?=
 =?utf-8?B?YVEzOWdpSUNvVXJnOTlDVktmK1dJa3NLbFpEVmE3Qlp6dEpYTHV4cTd5SDZo?=
 =?utf-8?B?SGFxdFQwOUUxZzcralJISkpPeGFQZ0Jmbm0yV2l4TEZIckpFaFRyQzgzTkFI?=
 =?utf-8?B?eEs4dUpXVHcyRnJ1bWJvVGx4UnpNYVB0NzRndEJVWTVuNGdvVFNjeC9Uejkx?=
 =?utf-8?B?anp2N0o4dURGOWM2UGkxUXpLc0VmYUlxNWU5YnRQZlpZc2JpbGxQeG5pbUtM?=
 =?utf-8?B?ZForUVI5YkVBQ0JoNzhvOGFvd0xvNm5wMFYwQm5vTGlpd1JZV2NwZy93OGpO?=
 =?utf-8?B?Q20xeXNKZU9lZUE1NGFUTUVWZHBGd04vU1NENCt3a0JYN0w0STlQV0ozVmFK?=
 =?utf-8?B?aDY2b3hlOUErSEpNQ2VYejR1U2wyVmd5bEE5MXoxYmc1QWtxSUo2QlM4VTZw?=
 =?utf-8?B?cTJieVluR0F2Yi9mY1RLNDl3OFFrMzNFbk9PYlplSG9pUUFRejR6b1ZXelZs?=
 =?utf-8?B?YU9OaVU4MjBWZ1pLNEliYzJIQnNBRGJUNkxIdTZDakppVkNWUERKMXl6c2Jz?=
 =?utf-8?B?MkdTc3Fxc1ZXQW5UYkE3L0xWY2pyZGVwbUJNbzREUWxOZnMvRVZOa3JDT3No?=
 =?utf-8?B?RzdOUXpQNTh0YmxCR2pyakwyTmFCQWZuZjl1TVRPU2haWWdJb2NBeHlJakp1?=
 =?utf-8?B?WEhXdDErMnl3MndoYXp2eDdFYndVNGZDUzgyWWYySGxQRnRYckczYmtjemZ0?=
 =?utf-8?B?U0hHcExWSXRvNHpteDhNZDZMQlV6N2NFMU1SUGovYU9PeXg3bEJUTHF1dmNT?=
 =?utf-8?B?L2pzNUJPcktaUmZMWS94UmJUQTdmejM2OXg5RU9BNis2eTF4bHpVS29EWUJv?=
 =?utf-8?Q?wScbX43RYN1kxx5vNnR5Qwq9PJbbePCqKufWU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98380a80-8475-42bd-d4a0-08d937f63277
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 16:27:59.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhHlLdYNQLELtZsniEaOqfPUCwBRscPRefFboIj+ua/ouGpZ8OaMpTaq+uU2uwuOFFmJ6sL3dB9Fkg1J8ZNHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3494
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10026 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250097
X-Proofpoint-ORIG-GUID: pzG_rpbPbSNlNCoKg2C4WXULFwyje7mt
X-Proofpoint-GUID: pzG_rpbPbSNlNCoKg2C4WXULFwyje7mt
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On 25/06/2021 08.03, Jason Gunthorpe wrote:
> On Thu, Jun 24, 2021 at 11:55:31AM -0700, Gerd Rausch wrote:
>> Fix a memory leak when "rmda_resolve_route" is called
>> more than once on the same "rdma_cm_id".
>>
>> Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
>> ---
>>  drivers/infiniband/core/cma.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> I wondered for a while if it would be better to clear this in
> cma_query_handler(), but it seems this is OK
> 
> Applied to for-next
> 

Thank you, I appreciate it.

  Gerd
