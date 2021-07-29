Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA35F3D9DE5
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhG2Gw7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 02:52:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52046 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234312AbhG2Gw6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 02:52:58 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16T6pZ5s003279;
        Thu, 29 Jul 2021 06:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pOqwfaDDEJ5ORDkm0OhEgZExqmOZpOW8FVqonTOOoOc=;
 b=reRGafoj5wuag1vg7V/MRHjmxveI9QFQdroOtdSaLlbKr96iu1KhFOtemOqDy1f2N+IA
 +qf03Tpv1T9H0jLqJrOZVCYtQy5JH1V5JyWpSjd7YZViqah5PzucOGqj9XVkaRv9uP1q
 9E3X2riP/lcQ721wNuGQTEBcLuMbLcsmiMkoJbPyHomqIxwURqX93WGB9rk97xt9/sl3
 A5DLCgsug6kIAadj7UTL9KnCXsX7vL85fLRvtOtKbsZL21iqwvcbT3C5K4X3FmYb/gRk
 +CuG4Pa2fDkGBlxBTKkifmIvwvbuoooL3kPRjIRple8s5TOHfeYAdZczKlh70gDhw/KX +g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pOqwfaDDEJ5ORDkm0OhEgZExqmOZpOW8FVqonTOOoOc=;
 b=nxmYfF4w0ieK4qPWO20ENwVTVbDNyXP6c5wxWMt7EtU/2Z+3A8Ms6jzXdqmO+bYM0xM7
 sRBpsehpJBD3rWArXR1QePMDqGQI0tsppRu/2/xr/UN0AhMnwH7N7WjUpPf0wnY6vGnY
 w3ux22KPs67kZypIe2olxeQ46G3x13aVbxfRsqv+36hmVeYd6qQM2zJJNbuWw8e43oY3
 cSYQkG5MGjk7RWIncgJWZjq0cZn6mkY70dNCaNHYwEqfsFKHTlHjG2sfGJ3bpt6al0AV
 Ts6ZMmKbLTneQ+n58G+WBW87t9k46XOAoF4SqP7LF5WFXEEJZrq6Xs9flp0IFifP0/0c qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234w6fv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 06:52:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16T6oqtN015368;
        Thu, 29 Jul 2021 06:52:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 3a2350a882-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 06:52:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPxD8Y59jioCACwmo6iCcvcaLFcjST2wGz2dhn6qdsQ51XT2jbbRom1o2IyoloDgSCdexPMdGEYDsriHY8pRD84hyI++QRyKmo44mZOSCYZ7hMqkAJKuGCLTashmAfGuGP6vKV/7lzd/vV2TOYPtalEUns3LD+3CRw4ER1llbsycRbB79FSjn6PDaBRaufurXzbxCCs8rzI9W3Af5f3HMDQNxOWJGQo8COH/31XOmEbsOeBY0w24dGV6blRvsLqRYkI4rAH8Ecgt9K9L5bfdbTU1VdN0Tdzr1DmQrBq4koJrQz+jZUBRXUpbswtbkCylSuEOngnanWjEEpHIvu9bYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOqwfaDDEJ5ORDkm0OhEgZExqmOZpOW8FVqonTOOoOc=;
 b=WV2rj3ZQCe9PWuBvYNQbDJWHzXEEw0EtGjQr9ugaj5X8GAFW1YPdFw18bsjCFD8FTnrk+3PhV8IFE0TBjdR595dpHvf7Q7dXfl9O5UYf5dnZrHlgM0Pz+2+GtTUP9PEJCCUVRjf0MFaHr2V1n/5x98KViy2a1MnoCoM+uSWBGMj0j5OT6GN7G63DQtW63Hx8WMmFVc4kOrEWH0t2Yi3Y4YZwqq9oZwcOe16aoX9xD+8s0b0NbnysAL/Iv2MoHZIS8aAnOgb5s5yKmWiWldwwcSx+mmeJk28NFXIqa3sbRCX1DlKhCvQdG2g6l5ULWO2VTy2lqMlgCXKbM34ilBszqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOqwfaDDEJ5ORDkm0OhEgZExqmOZpOW8FVqonTOOoOc=;
 b=PrIYakp3ewFNAzk2bM1SldBOZqKFFwdLYuoZI4E6iR1s8s8pC/FsFhASzqk1qG7VtlLYQXmFjnMwbPDAWtj/bT8K/VNjU2SlDO2lQvg0ui0EfRAftUuPNtyc4DaB7El758LnJQNO8Q8aZyk5wjSjYHBi2+cDMB8LMY29/REUXbc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 06:52:51 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 06:52:51 +0000
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
Date:   Wed, 28 Jul 2021 23:52:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0028.namprd05.prod.outlook.com
 (2603:10b6:803:40::41) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::4a6] (2606:b400:8301:1010::16aa) by SN4PR0501CA0028.namprd05.prod.outlook.com (2603:10b6:803:40::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.9 via Frontend Transport; Thu, 29 Jul 2021 06:52:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae45ef61-df0f-4a15-e506-08d9525d7bd7
X-MS-TrafficTypeDiagnostic: BY5PR10MB4131:
X-Microsoft-Antispam-PRVS: <BY5PR10MB413152F7AEB5357D3BEFC116EFEB9@BY5PR10MB4131.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2YdSq+8OHJM/SEWobbEJqa85D6sp2UGyGdKzx1vjIFT4cSKS5flgp3ef+Nu0QXLHaOOohr+0AnvIGuDQyXfj8isjNIbGRQWlciRjpKJbOyRjWlCQqkHmGiNkWEjef0gaIj3MAzsZkpABVPo0hyzpwj5S5fTgBF2RBbpLmpbylEQBbGXz+3JoTZvYvSkPPOy0TmQj7YJJnryZTNJL0X71TossA6RZtEj5iSAQFOlCgCN5+hFKfR2qvrzIHlz8VE7QHLDRs5r9rSaZ8Eb1GzGKEEnhQYwIyHR+j/8TcMGApkINryNQNz+WbNjPW+Aiyp35cc6UhZfRffg7fJvBvdJtF9z6s7RPTK8WhEFfnHG2WT6C2UqN1D+c6dqdCt7wqS385fTI4ksw2gJ4py9xvL2m4EM+vlRWiVDe8y8S5FhOn72ZpRUPtUzfuuR4w1BxP7kla1R6qwGHa1unD4WNOjb6Um7pS8V5EiasFxkb6DGX1fAcgxyidWYFHta7G5r39bBp0sL1mE8VSkZrjvUfJR6tk6r1kEP/z0S7eV11eonszbqyJ9i5Tl0geI0bhrRLXQvuX5147bLazGvVoPhGJM+4cCciGPvoPDcu7b9hf1rwwUlPgQYhYMWV+IDDoxvEn2Tz6xfjiSkdglySUtknkA4SY/LBH8jnnzOv4Bzn8IqlqB9/AEXQOfsYZVIWK87xq1Nwgx5LVcSrd9Owg31PKnp3/lbFEYeniSkXI+kPkcwbtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(8676002)(186003)(110136005)(5660300002)(36756003)(316002)(31696002)(53546011)(31686004)(478600001)(6486002)(2616005)(2906002)(66946007)(66476007)(66556008)(4326008)(86362001)(38100700002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmNmdFpvV1NRNXhpMlJMbE4zUUw4R3F6cm9FYnhRWFlSM1IxbnNLT2FoT0FM?=
 =?utf-8?B?Wklpa3RpVXZDeXhZYmhTUnlmS1lTWmdPK09hclppTk1yRmRWUlEzak56UzJ0?=
 =?utf-8?B?YjM3a2VzcVlTY0tiRUVmTWtKNXp6bEdNbEt5MG0rVmdZdHFNMTNnNkNpRW1R?=
 =?utf-8?B?NUw1NTIybWtDejREald0QmExajZJVjQ0NHorSlVLY1c2ejhIRlkyRkF6SkRR?=
 =?utf-8?B?Z1N3Y282S2h6S3dDL1FUZXVIZE4rcHJqKzg0NDBVaHNudGUwOTdLREdQTTZB?=
 =?utf-8?B?YSt2dHZkMTRvS29LUWc4NkZQNlZ3ak51WEU1c09oVmNaLzNacEpaUStEK3px?=
 =?utf-8?B?QktaSlUxTVVDU2hHb3d0NzY5VFNMV1oxcWxPdEVJRU8wZzYrZFdwMjBDRVpP?=
 =?utf-8?B?cUw0WVN0ZHZqVVFyUXJlSjduMnltNlo3WmVLcEVIdnhIREdsbytXUlNlamIx?=
 =?utf-8?B?YktHWGJmRVhOeUhpOEcxTzl0VUxtaWVNTGRhSHVMMTV4ay80S1Y4SzBFUXJl?=
 =?utf-8?B?c2F2VmhZRlgxZzltL2tTR0UrOThFUkNLRmdnajVmTW5EUFFtZEpMcWQzU3lj?=
 =?utf-8?B?THpjK1RzQ2V5Wm5uNzRQMzN3ZnVuRXhxZTE0U2lZQjVwVnQ4bHJMNHJXeXN2?=
 =?utf-8?B?VnRqSXZOSVl0eXBvOTdrL1Z0d0RwWXRYM1hINW83ZWlCYS9nb0hMbXV4Y0ph?=
 =?utf-8?B?V1hnTkNZd1FkalhxZjJyREZWNkdVSFZIeGs2cGRubmVMcktXVm1kanFSbEdr?=
 =?utf-8?B?dy9rN1lraGdvcks1QWNrOG5ybnRKVVNmNGpyUTRlbWFDelZ3VnNuSXZTcHk0?=
 =?utf-8?B?RjlJTDJFbWlNK3ZYQ3ZvQ25iS0ZzNEdqVXl1N1pnZDF3NUdtL1lpYUt2ZnZI?=
 =?utf-8?B?RXdIR1ZHcFZYdWpMSEJJSU1HSVFLa0ZrQ0lnNG5STHpabUk2TkN4cjBjQUlh?=
 =?utf-8?B?YnVnNld4UlpvM0JzdDZ2U3k4VFVkcmxvMWRvaHVKQjh5Q0tZYzlaVjVEM1ZO?=
 =?utf-8?B?KzQ3VHovTUw4dUR3dnF4MjY3aFBIcXFKZzZxdldGTmYxM2VtcnhDQ3JUTEtD?=
 =?utf-8?B?ZURQWGFhOVpLOGRTMlNIMnI1RndQYmM1WDQvL1hQb1QxQnF3WkdNdmhFMzZR?=
 =?utf-8?B?L0NabWxxS09KWUFoK2VMYThLZ1lNMEhpTnJsTytjZzlUeVF4SWhOSHowak5Z?=
 =?utf-8?B?QVdUSGJ1Lzk2SGQ5SHRsc3ZvTVE0SG1WL002TmI1SnREZW1mWWtLTVZ4bkxi?=
 =?utf-8?B?QmFTNmVYZ0RnNWlVSUtEWFBjM25ncVhuYlJlakJIcHE1bEtmRDU2SlZrdUJ0?=
 =?utf-8?B?dW9hd1RnZWhRZUpKa2pHNS9ZOGdZYnRUc3YzSHRmY2h5V2l1Y3ZhQithRjBK?=
 =?utf-8?B?THV6OVpWeVBYV3ZVR1NsQzV1d3QvZ0RPeWhKQktxTkM3U1RsbFdleWlKdThM?=
 =?utf-8?B?K1J1b0xDRUprdGJMVkdJaUU4empKbXJSYnd0WmZoV0swVWtqcGk0RlRLT1Ix?=
 =?utf-8?B?Q2VLNUltRHFsNkVNeFpBaUFPelgxcFQzcHZxUGJMckJ3NE9HQ3ovRXJOMFhZ?=
 =?utf-8?B?VnYxd1Z0T1lvWnhVa1JOWDJVcDdmTFZPamgxS29SdUlIaW9JN2tXUWJINFAv?=
 =?utf-8?B?T05EZnU1Q2xHVjl2S3BsREtkUERBNnp1aHE1dUtmTjNiNXlBdnFhMTlnY0tV?=
 =?utf-8?B?YTBJdlJFVEJhUVpaSzNjZnIraEFKeWF6eVIwMkE4dDMwV2hyc0lkY054VnFo?=
 =?utf-8?B?MmJlWG0zU0NCRjlTemtHb2Q5QUl0ZElwSzN5dGIzRGdFMmxpdmJkTCs0M0Va?=
 =?utf-8?B?N0VSeFFFdVBVcW94SXc2UT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae45ef61-df0f-4a15-e506-08d9525d7bd7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 06:52:51.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEj+MGDxaye04dqpk2JZP0fQ4yBJlXvxPKPz3n0RRnZnL90BGJ4zA5JKHcOldxoGGxvm1JxbM1fw0caO6HA0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10059 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290047
X-Proofpoint-ORIG-GUID: bf8e2HMj-x5kZxrTILX84StfJOB0WdYF
X-Proofpoint-GUID: bf8e2HMj-x5kZxrTILX84StfJOB0WdYF
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 7/28/21 11:42 PM, Zhu Yanjun wrote:
> On Wed, Jul 28, 2021 at 1:42 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>> On Tue, Jul 27, 2021 at 09:15:45AM -0700, Shoaib Rao wrote:
>>> Hi Jason et al,
>>>
>>> Can I please get an up or down comment on my patch?
>> Bob and Zhu should check it
> In my daily tests, I found that one host 5.12-stable, the other host
> is 5.14.-rc3 + this commit.
> rping can not work. Sometimes crash will occur.
Can you paste the stack?
>
> It seems that changing maximum values breaks backward compatibility.
>
> But without this commit, that is, 5.12-stable <-------> 5.14-rc3,
> rping can work well.

That is strange because all the large values do is initialize the pool 
with large values. Nothing else. So unless large values are used there 
should be no issues. Is it possible that the issue is with 5.14-rc3. Do 
things work between 5.12-stable systems. Anyways, please post the stack 
trace and also information on the setup and rping commands used.

Shoaib

>
> Zhu Yanjun
>> Jason
