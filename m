Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0BC318858
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 11:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBKKi7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 05:38:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36652 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBKKgo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 05:36:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BAZqOv080997;
        Thu, 11 Feb 2021 10:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9qZ9oUdurw1Y7M1Nj1iBB0ydR8bDd2PdP6l4aaR1c3o=;
 b=f+cQOEVfqQswDG8hawjzwyYyca7M5AOv5qPGi4i9hXuJ4xco6DVjLHFz9RZKvn/BSMJt
 2lEZYVfBWlY4kD2FcBpLbxaO5DCYSm6/nFgEDitWovf+8/ZwDypo/phGTr3ZXwEO3JpS
 tMJla7sko+01gfFD5tbSwWghXg1XpCfaUxYyBcTttvn2WCXoabUiQbU0LjB4GqpYHL1V
 T/VLH7MVEuk/QRKdq9tqyssnf++IoQHz8TORBy+r0qtHNiANVGg0cL8aejo/bffRtw7R
 sG0jTJRuE30WScm0QC3k33M7N5Lz3vAjXUrWeIa9w/guN3zImb4n5keI55xG4GEhSe5G gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36m4upwg81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:35:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BAV7pA049697;
        Thu, 11 Feb 2021 10:35:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 36j51yujhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 10:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tga5zwXUrYVHGvsTRQ0RnsGgG3cffdg+P9pobJN+Rxr/2TLLAstuWel4YtS6XlacdxhFAlpXMJX+3z1dTYz8uCi1f9h00UJcZ2EAeCVFuRjzLHrsy777WVy8vxF5/FjDgN6hMn/DaNJ2Y+wnz6sNACKZj/GKZetFKHHTCjpZc24196Zcr8hkc7nbCzAZdhfzbUyLXzrpaoa3pqq7kslhhmlBeMFwOCe8PWBgludpDNO/Etur+xeXJxDbrlZ+i03OteCuf3AH7K7ct1B97WROYtPhK63/iLgzkpLNBtITWD8SB9ru3xAlnCxyYdRZ3nAuzh4WSapNBO95abnEGf1UsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qZ9oUdurw1Y7M1Nj1iBB0ydR8bDd2PdP6l4aaR1c3o=;
 b=UkIeBAGhPG4dhtqzVKvfeBvd/pQ5HiiCFOhH7nxl1yeyP1n3jkTLP4+XdW03O4GHdFT6+kMoBtznKqD8LMP7se1YPVxkB02uEq+v/owpGiKCqPNnR1UwJlhFXjbaTBMy18OwSBi80Zt6zcdmpeUczx4Hi0Zhw5bczvQ3tUfae+DZELKkf0dCqIjJRDU4AjTt7SjGuSUb1jPQjsq9BYtMxcdyumnvF+ZUttuMYOtvX+aZLS4FNpof7ceHuZWsGRZJgrYalejFZ0D4EsrZLRuMHYir6/eJEQqjZT68+qt9Y1aEPz7KOzW2eDTmg0QW79YoycQ8ykP0hamjHHNQttQsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qZ9oUdurw1Y7M1Nj1iBB0ydR8bDd2PdP6l4aaR1c3o=;
 b=KRHYGGHx3l6PHIIHxiT//1/dXplDXU3zX7Swf3+8rcXl+SYVi3lFFBFhW4gWyRYMz1VdA6z4k2g2D2QUSwzlwM2BiXPURHp4M+xbDuA9cxCfxuMiTg/0NBxD4t3Qw1SfURb77/nJJGXrOCNvX3uvKI9R9kLFnpNwxjSAo3nkxgQ=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2616.namprd10.prod.outlook.com (2603:10b6:a02:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 11 Feb
 2021 10:35:49 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:35:49 +0000
Subject: Re: [PATCH v3 4/4] RDMA/umem: batch page unpin in __ib_umem_release()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-5-joao.m.martins@oracle.com>
 <20210210231734.GS4718@ziepe.ca>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <f5f5bd91-df18-1d53-28eb-286336b976dd@oracle.com>
Date:   Thu, 11 Feb 2021 10:35:41 +0000
In-Reply-To: <20210210231734.GS4718@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LNXP265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::35) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LNXP265CA0071.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 10:35:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd689004-abe1-4fbb-6574-08d8ce78cc34
X-MS-TrafficTypeDiagnostic: BYAPR10MB2616:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2616837F7997794ABE6ECA81BB8C9@BYAPR10MB2616.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23XQMZ2kR/iA4px31Kalsz39jt+ZjDkgEEhnd/FrmGYoQEEQiDpDPHNeXhZi0StFo295j+KNRoCc1ErMJbvZP4+4KBYhpxJ2xm1G8BEu6DrjWN2Tb90etNnrkjxUysZEHhcoG2GugHK/Bv97TrQnHd58lLa4tc8WYtLVj675a69KVKz3e0GqOpzZ4xeQTR0avQMZjzRx/ClLofx256OuDFg/UtCtBoDOVtJcsWGm20GuvtI9Wf8rqRX6buhDXpaHCrIQ6kjUpZyq4a8nsycuuOhOziGc0G6O/nDRVLy5Y74+sM4dBjq354tUjxlRVifKEC/VitmkFBTsHydxg+txcfjCKmXuTOiB/XFDOh8PGNQVOePpP4h7/5uqs3ytyDMFz7XsLeYa5txS4MgVcIxyAv37kcMEtUWLb5/Fg0i7g7tNCO4sB7cjP9PZ3/TpYGEeXIpf8Nk0p5qKHqLIAcyqyVw4Ba9fVOai8afviJp/A0swsju7gKl0weBdVVWfbuRwCatLNF8UA0H+n/2bMYn+UveiBudh23qzSPzx5DsCeBA/50hG7axiSE/PGBB4wY2Qm48udEtBZrodcysYCPHleg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(136003)(396003)(2906002)(6486002)(2616005)(316002)(6916009)(66556008)(16526019)(31686004)(53546011)(478600001)(83380400001)(956004)(31696002)(66476007)(86362001)(8676002)(6666004)(36756003)(66946007)(16576012)(54906003)(186003)(8936002)(4326008)(26005)(5660300002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1NlVTByckdnbTMzMW1WaHBnTGYyb08zb3VwU0dqdHVUbnJFb3Vtek5qVFY3?=
 =?utf-8?B?MXBoZFArTUMvYmdzYkw3K0piOFVEdCtnbHFkRmhVVGhSaU9RWWlyZk5OWUxh?=
 =?utf-8?B?aWZwSW1rcDdpanNsQ0I2RGNWcGZyc2tTUlAybGE1cUE5U3d5T1d0QlBkaDBs?=
 =?utf-8?B?QjBsWjNsU1JTSG9PL0pRVU91TEZVN0R5Vm5Qek1YQnNTUDZFQTc4OXd1eS9I?=
 =?utf-8?B?dDhpei9jKys0T3FVVkpBL1lJMW1VQS8weUYycW85M0xBQ0pVaXVMK1F0Y1Bk?=
 =?utf-8?B?V29qOEd5MEpUaWt6cXl3aGx6ZDFHNkFibFJ3MW1xcjIra2lCUnVFUkRUQWNE?=
 =?utf-8?B?a0pXNnorWlBKNnExZmhiOG5SZU0waWRsSUQxek05VFN3dWVhc2JaRGRUNDdM?=
 =?utf-8?B?VldwcC9iTkNOdm5pSXBaTDRyWlp6WE1NemRaWmhYY0w3cVhGR0hQRXUydXdZ?=
 =?utf-8?B?RkN5RWRQbXVFWHJ3OEFVNWI1NWhDcWVzV0VsRnRGb2RYckxvUlFQaENnVFZ6?=
 =?utf-8?B?Mmk1NU1wSmRweG0xZlloUE93MXhjNkk1TlFNTXB5aEZhTmZ5ZS94M3Fna1Jo?=
 =?utf-8?B?cWFYMVRlc3pucmM5MjVhcm9vUktXZFNlUjJuMThQalBzVkMrdGNTSSs3cFFB?=
 =?utf-8?B?WlY1QXJTTTVWVE1XMEZKMFlHUXRPcW1lVkZEUmNxbXZ4UnN2ZlFDVHUrUGox?=
 =?utf-8?B?akFmcnNNQ2crSEFCNk9EZ0xLT3NkdGdodXZTcXB2THlLc2hVZXBQV2s0UXps?=
 =?utf-8?B?OUlHU1hZTU9EaHZvNExqcU5idkx0OXNBNVNjMnZvZ1VYaGI1ckRJY2ozMVF5?=
 =?utf-8?B?TEN3b2hRV2dHZ2pHemxaOEt6Q1kwWWVhVFdpZEpJbUdYcVc2dVgxSU55bFVi?=
 =?utf-8?B?bVRzVG9MT3NzcUViV0tNN3VsUnU4RDE2UGNpZDRnZlVxNE9GRzFocTZ0YmxZ?=
 =?utf-8?B?b2xxVVNMajEwSjhUblVHMzZjUVBhaGExT0cwbjdEOHJ2djhoWjJWSWpFVnIy?=
 =?utf-8?B?MDVXQ1poWUU3cnRVcmJId3g2V1dUNmxDM1FuaThWUDNBZGo4VVYwcWMyR3Zk?=
 =?utf-8?B?VVAwVWc2RUI2Zis4UU00czhHbE5zM1FsTXJVT3Z5OWJNRGp2bzBtcEFFK0tU?=
 =?utf-8?B?ZUd0ZnV6WXRwd0o0dUU1dUdCVlVVSzhnMjFkOTlwYk5LQVgyeS9tdnpTaTdq?=
 =?utf-8?B?d2grcGJIdkRCMGkrK0N5NnZMSitTcFhST0hmTmhUT21iTWc4dzd5aERQNzYz?=
 =?utf-8?B?S1RLenMvQlIwc1VKUTNkSis4UUZ1UlU5OWF1UnJqejNyRUpYVlZrbXpLRk8r?=
 =?utf-8?B?ZkNMY2NGYW1Pdmk5ZERlWnEyZkk1U0RVQ3JEbXJsS0JVNDBYZDlxcEFRZXNp?=
 =?utf-8?B?UnNraVhGeHlIMmYzb1ZEbWxqYittcElneUoyWk1vMS8vaFpIMEdGNnA4NjQ5?=
 =?utf-8?B?bWdWWmxMZnN1ejdiakRraWZLUUhyZDdMQngwMGl3T0xLcXpvVHZnV1RadXJk?=
 =?utf-8?B?NGkwUm1TWlpyeEQ1b2loUVR1MXJnd2l0WloxcTBLRXl1L2ZUeTNWb0YvV1pu?=
 =?utf-8?B?RExvckZjUFRnRFpxYUU0bnhVNnZJRnlSdXRLUW9vOURacElTaExXWFQrdmRD?=
 =?utf-8?B?VkhiMXVxamNWQ0c1Yk1yRFl4TVdPbkRpM1ZGYjl0ZU9qUWpqRC9JSEpPM0JL?=
 =?utf-8?B?S0xYRkVydURNZVZ2WmYrcjgxR09paXd3UnFFRlNESHE0d0Rya0c4TWdCbS9m?=
 =?utf-8?Q?A0+/kzbpDhKFsh2yAtiOgb5eVLEAqbodDfdM6Bj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd689004-abe1-4fbb-6574-08d8ce78cc34
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 10:35:49.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qcUdyk0VUl78DnDOmJqePLvngBzvp863PuPUylFMOQuyQEOiYEnjV3NdIo5fxCgIJsbeReHp6DA+RjcERME2K0+FKUTix4/+LQtXhiOa+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2616
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110094
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/10/21 11:17 PM, Jason Gunthorpe wrote:
> On Fri, Feb 05, 2021 at 08:41:27PM +0000, Joao Martins wrote:
>> Use the newly added unpin_user_page_range_dirty_lock()
>> for more quickly unpinning a consecutive range of pages
>> represented as compound pages. This will also calculate
>> number of pages to unpin (for the tail pages which matching
>> head page) and thus batch the refcount update.
>>
>> Running a test program which calls mr reg/unreg on a 1G in size
>> and measures cost of both operations together (in a guest using rxe)
>> with THP and hugetlbfs:
>>
>> Before:
>> 590 rounds in 5.003 sec: 8480.335 usec / round
>> 6898 rounds in 60.001 sec: 8698.367 usec / round
>>
>> After:
>> 2688 rounds in 5.002 sec: 1860.786 usec / round
>> 32517 rounds in 60.001 sec: 1845.225 usec / round
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  drivers/infiniband/core/umem.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Would best for this to go through Andrew's tree
> 
> Acked-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> 4x improvement is pretty good!
> 

It would only be half of that improvement if it wasn't for your
unpin_user_page_range_dirty_lock() suggestion, so thanks for all
the input :)

	Joao
