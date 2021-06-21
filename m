Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C43AF02E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhFUQrI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 12:47:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64158 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233642AbhFUQpG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 12:45:06 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LGbNkX023392;
        Mon, 21 Jun 2021 16:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=C8HEh9ER3WUiAgpR3Mb1QJHFLiR+mV5tlXl1urXjsLA=;
 b=SJ7/DhmOV0eQ6zSRECckH9J+bDamOqINDwvj6sGNcUy8HiX+RfTo7c4gqXvFywh7KvNZ
 ifgT0pFkpTNadEA8k9/eXCTvVgw/FVkb7FbHR/7xNA8Stdkl8ybX6TNRd3HlSlB05jZ9
 QkD6G9WJ1wNKmnKoYTt/zhBkgj6dG5ASK1C6cmKLOLMvNd6ve3+B/Ctj3+x+ocSbVadt
 Y5QgUgBqP6TSSNJQuVO2RqP9LEFxDmF4BHfOEgZr+62O6qxnI4LTcOxzuJqPKqeYVuIc
 dGbUZejKMoaIHAKfbJfXfMFOuzJGqzGRftOf3BiTsiW7mrK0mL3yyt7B6ObwArhR6IWD 0A== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvs01v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 16:42:51 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15LGfHQO114467;
        Mon, 21 Jun 2021 16:42:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 3995puv2qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 16:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnUUs5gt4sSRlVgm6xQ/diBlTbHePDjAlvq06UIqtrWBjrWKLx4ubT6sEpbIaP6y0L4BO+IVg7ELDDljmmgItPOIzxhd+fdY8Znvb0lISB9IhvFLU8UIzwIUdzT4CIGs1RqyBQs9d0vTdWUd9XdW7T+XWyDvTB808NC769yMy3V9XHhX8FYZ7Jcb5o37rEgekWEsI/sX407yJ2cAhjf919Gi18E7yIqcumpFprM8jjo79y+/I7jXKmk6CDSC2Bd68mun5mlX0EmNU0iAQ9V1Ojyme/mQ/NQqwc67a6bHlYliO6x1eAlSyv22glPvsq5wJV+CuURO+yi8t0MTFAesvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8HEh9ER3WUiAgpR3Mb1QJHFLiR+mV5tlXl1urXjsLA=;
 b=fTr3ZJghV0FqaGIF271+1GHb/nfKOaoVLoWDh1NeP1m8NuNcHmmJCu65N37jAJlQvtuGobTFvHaDK5fp6fEYiEt18ui3pzmv1GjFpiVol1jEunfqd5FtNCJ3c9qRkfhaWWfTBcXMY/YyiosZfE2zrwdYKzsTN19DivbtZ4hzlMtiaGMMQk5r9Duxar4XdeIALAXvMqp23pt4+y0Twgm8TTnNJ5E3fyuY3lmZiqHICLgXI6wKC0SL1g8daS6TUmUIJ0MNI03NV1uCwAj1X6eoJHKrop+212leRhHLG2fBYpYkER3kRB+von2dr1d/TIKoe8j7R4+zM84vTMKLA/ltMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8HEh9ER3WUiAgpR3Mb1QJHFLiR+mV5tlXl1urXjsLA=;
 b=Z5i0rrpWc82ovClb8TKkGTd4O66cfl8ZRnV5MkvUQpe+zgPJBqROmlQgPAA//Bixun4GYa6VcMnrzWurRxRbaqKl3KXNDq6pH8G2uN+ulicXvd+Jvazka9UQBERxPQibIQleQRsGj7hJl8IWEpDYhQbaBgq5jD7zVs5qxF+Nnhw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB4781.namprd10.prod.outlook.com (2603:10b6:a03:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 16:42:48 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd%3]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:42:48 +0000
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
Message-ID: <6817f1cc-d620-5908-944e-1fd61b3af61d@oracle.com>
Date:   Mon, 21 Jun 2021 09:42:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210618232535.GB1096940@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [73.170.87.114]
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (73.170.87.114) by SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:42:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9a85740-ce2d-4f3a-dd4e-08d934d39a56
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4781:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB478163D059C8B27FE87D49C4EF0A9@SJ0PR10MB4781.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oevCJ4axrX1GkL6ZxyVt0RcJ4gV316mZVCk5YM40UgzQlcjDyHvrFmqJrdnuqMtT5p0RgJvjnFvVfgfJwvh/TgJ4/TOA2dMNaQ8b16hCLUvjwk+W1g9z4S7Mm0pElar+DulFlcZuU9utVEdnhnzCJcQIZncwoMWnuIDZ68GBWW5E31oIoq9qZj/4n7s/1Jqs/+ko2lg3DwFqy0f3n6M7pVxIXOsoY9ByNObIIJzOxFeJvOPur3R0j11+6qUrw+bUvffl8tzI+T79O3ZA3bVNsW7gnFMFMUMOpo6JQLURDYuNLXemW6/6+6G0y7GVdZG+qp18jX70EqlAuYGHT2ElKmHUXsgEAyQh6y3L+6PasUp7SVSQM2vSxAe/S3QB1lI0TQGg6n8ImYJ37dh7z3PuSJqxnDXCfFIDIveCcjdD5eCRhw379Fn++OMjSpb10tkS+9q3kgCYofskkMFI9lpt3n/t+ASVbT36odcEuIkxEqyhAp6LyQqLKXV/MI2Ar2Sq4zskppkjoWYKisfCE3McqzaRqsBvQL9MBB+X/5euamndX0bKLo7aH4cHqnCJXqZJs19Cfw/tcMLnFC4DjC4X6ILE3whdMMssYc7DCCWmIHX9sBIwTnuIv/x9BgOwPHk4sA8xt1QMxiIy+UkWYnUv2a0uGXYMyJSTGVuNaSdHYp+ljxNfaTn6iCfDVGUjZ3uX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(38100700002)(83380400001)(66476007)(31696002)(66556008)(31686004)(4744005)(66946007)(86362001)(2906002)(316002)(8676002)(36756003)(956004)(5660300002)(16576012)(53546011)(6486002)(478600001)(8936002)(26005)(4326008)(16526019)(110136005)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NBWStsNFhsaE4wMXE0OXIzczR4aStvYmo0SGg1d21CaGEzeEVpUTc0Y3Yz?=
 =?utf-8?B?SlJhb0FEcm1mRXJkY1BXZEpPc0ZvMEZOTjV5UytVU2dXQUxZQ0dQS3c4cjVy?=
 =?utf-8?B?aHR2cWFORjJoalNaa1llRy9mOUpOajVzb3c0dlIyOFg3ajI2OXhsb01PWGhD?=
 =?utf-8?B?ODF6aDRtUVh3ajRsU0d6QWdTZ0VRNXBPNXZ1YTF6QUhZK1pFMnhUOG1FY1l3?=
 =?utf-8?B?UVIveHBzcnpzc1BNOEhadDBqOE1Ya2pscjNYNC9HdmlHL2hCbWxnVmc1c1Fm?=
 =?utf-8?B?ZUdER3pQV0RYUjlMNWJ4NjZvUDByK29jZmN2eThjQ3d0dmdBZGlVLzVSdkhX?=
 =?utf-8?B?RjJqVGw3c2M3bXgxQnZ4b0hsM1VyZGhkaGhsNk95MCtJbk42eEZ4a0p1VVow?=
 =?utf-8?B?eHFSbzFSNTlLWmVJek1RcERxdUFFUlBZSVpsbG9ueDRCZnQyVjR3elpTRThY?=
 =?utf-8?B?b1Bid09EVVpuYy9HYzJrdVZKV2RJd2REQlovTUdDM3p0cXlRY1pyQ3MxNTdY?=
 =?utf-8?B?ZkpvZ21YT2tneXdVVXViVy9CM2VCV0kwQ2tkQWlHV2tYMHF6M2crZW9Dd1Js?=
 =?utf-8?B?UlkyQXJQZXlIZnh1eTFtWW5xN3JQaGtDWlUrNFE2eTVVZ1BOOHkxTXhEY2g3?=
 =?utf-8?B?ZElGMkRlc0NuWGNLa2M5RXdmRHR5Szc4K2pwT0lTeGVSenNBZEEzdmxmTnl2?=
 =?utf-8?B?MFNYaHBkcll2Q2pET2dYbVBhNE5YbjgybVBPZU56dHlXSUhGNDEvS1IxalNG?=
 =?utf-8?B?QWlESlJJVGhxai9yekx6UUc1VHlJQmIwTmFNckVVZzc2NHRSekg2dGpKN0pY?=
 =?utf-8?B?V2dUYTFVWjBNNWFIS1NiUGIvTGNPZzE1TWFLZ1BXT2MyOFlxajVkQWpITjdj?=
 =?utf-8?B?d1QzRGRZM2tXWlNEWU9qSlNPcU9sK2hqemFrajZkdWNIbDMwajU0TU1yK0dj?=
 =?utf-8?B?NjJhQzRoaUg0ckM4U0FtUjFUU2JjS01mOHNmZlArbTU3UXVRcVBxeUthZGsr?=
 =?utf-8?B?eWlyNHh2Y2RCYWVpTzFVWUlXZ05zUDJIS1YzcGxhaTlQa0F0Sll1S213Q0Rx?=
 =?utf-8?B?TUZ0N2M4ZHJBb2EzQzg4WmRpZ01oN0l3Zld1TDFWZnN3cC9IMlFTSG5vTkNa?=
 =?utf-8?B?L1lIdEZydlE3Lzk3cXppR0FFejJPVVRqMVBjT2I0T3dMVHZxbWhVaDN6UTdP?=
 =?utf-8?B?WlZiWVpIekxQcyt3MlUwSVdVbXJOYkk4NWcvMTlSOUcwdHZrSmRESlZLNVR3?=
 =?utf-8?B?NUc5VVZDNDM4OHgvLzlEZVZmU3NPazlQSktKdDQ5Kys5d0tCcDd5eVRCU05H?=
 =?utf-8?B?QnhRd1NzcVFPTHlIamJsZnp6QkRvQU4wRWFIaHNhdU1TK0lBMWtRZXhMOUtt?=
 =?utf-8?B?Rk16MDJ0Rzl1cGM1TEpTTER1K2VtR2llTFhPVmVEN2JaN1I5UXVkM0JwV3NC?=
 =?utf-8?B?cnM1aFc0QVNIZXJkdGpOcTVsWjlybHJDQU1NWm94UXBUa0lzVC9adUtYSEZ6?=
 =?utf-8?B?VHVjbUhGY3NsTjlaTkFORVdVMTA3MGN3QUUxSnFxeHhLYUNQN0FDS2JpeE1Y?=
 =?utf-8?B?RGpLQWliRFhTcE04M1p6aFoxU3pWRG5nc2F1RFd2ZkxwU1ZsaXU3RU41L3Vo?=
 =?utf-8?B?L3VKM1pKZW9Kb0hhZEZxVUxYTk44RlRpK21DV0Y3MXEyM2pSczEvTzdxQUV5?=
 =?utf-8?B?UXdZZ3d3U0pwcXc2QlVLKzR1SmRLY2REdTV4eU5yazNNcFh3S3AxR0pQZGU3?=
 =?utf-8?Q?cuEe2+IaxtheM/zwjvBrM+z2JwQGA/MFRfl69vF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a85740-ce2d-4f3a-dd4e-08d934d39a56
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:42:48.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXlOOJsiOeOqf5JFt/upg17x3wPKUBVMF9DsVbzdQc1F3Xs1W+vsBttQsntLZJ7UOSJsgbcErX2WbW0bnmxk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4781
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210098
X-Proofpoint-ORIG-GUID: OCtp5CR8uuXzuGjbOcUiRo_GBOSyRMKt
X-Proofpoint-GUID: OCtp5CR8uuXzuGjbOcUiRo_GBOSyRMKt
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
>
> Jason

So do you want me to submit a patch that removes all limits or just 
these limits or something else?

Shoaib

