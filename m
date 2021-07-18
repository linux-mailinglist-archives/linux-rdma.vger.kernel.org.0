Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E103CCB7E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhGRXDK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 19:03:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11426 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232582AbhGRXDI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 19:03:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16IMtn2l014978;
        Sun, 18 Jul 2021 23:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KrvLxx6HpizIt/WHf0QqyUTt+inDiIf1H0EF5thGIJM=;
 b=EQGlEE1TlKo+tsx1+Lj4fjrxJUq4geaKCSCw6oQ6UW3KHxsDDl6utq41QYxsh6tkPYkA
 ROiUhkqNVjqifFHWr9k+RNNt3s48cHDlU9olYqCk6DcgstAIrl7bYzNlouXgxIRMId8s
 rhqjYFu8wImwECN/wLktzGm6BtGFxq3B3XmnZHJqR6V/pxaCoPG/ti9XnFrwhKiPTczc
 4hJGRUfz9eoK8wfb4VfIfMkhh7YXbrWWDYMLNmdkIZPH0LRminG7wgzAn4uwKtBi93R+
 FUrj0ipnJlG47XtUMJSDTw9qL9jKwgeYEq5jAzYw2iqA8Qt0K5QVs6GzZ9lH5j5t29+k tg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KrvLxx6HpizIt/WHf0QqyUTt+inDiIf1H0EF5thGIJM=;
 b=RwHBdUtMugIYoHawpOj5b6QFePbd1ZBYMqbVOWocVhawfmaQdYabbw9ruNXrMfjP9XLm
 lHBqFzc7bJRwy1GvOGHBYrMia6YJZ9sUTHcjRgIacmW+K2eUqc4Mj2CQwyd3bOLACTrB
 2RhmcMWpaqYurIQ2ybIOFs0B0FjZO3aKlys7It0S/4jO4lEbhKC1E8qMOBqWMdgXjeJN
 C2HQ5keKPsOtKoqkxPFf4lRPYmQHMaPh/KF0lyOdhu7t4Cbxw9mli7MMz1QBD7RgTXya
 6ZBX2LuxdgRbjrvBOYM3LNc8Y49/J24qDLocCWeFL0QLLH3Ic6jBfef8IGA+k9mxatc+ 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39up031skc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jul 2021 23:00:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16IMswHI175318;
        Sun, 18 Jul 2021 23:00:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 39uq13mtdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jul 2021 23:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB1SKkyljJ1PtidxGRTZXcZteGbrgbmWUoIGnsLR3X9V/MvtRk5iEvDHYlWPF2bDfO60dxK++EdKdsE3l+LWJgMMvXVlfOvupMJCFq/SDJ3pDDBoT8B0GnSPwUls+KrLehvpa/qy4cHkDGOPGB1oZdjBtcQW9Is06mqEL9TbBq1LW6UzlHTcMpX/UQTEoGIkd1GAKY8k5BInceAYaPP9xJ2VsDL+13yW5cvbumJCmFUpzsD+o7uGWId9JU/J6Ua5NRKBdNFfcUnTrlxSEsBGoiwTSwU4vfFx+iiIiC6GoYB4ef+BMx77wWUsU+v4zAgkJ3pJV7VPxwuIeMBd803yEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrvLxx6HpizIt/WHf0QqyUTt+inDiIf1H0EF5thGIJM=;
 b=IVofJLB9vFVUOjomtppECyifLS++mKO+NuYcNxebS1ISE5zne6uCMJbGDux6Uehmd6Pwb8nEMkArqbaQMo+sy8RJ6XLGGFBZtlfpv9raSWfDyEOg9eBdhg/3rVODnwlubyXsIrX++OHz/qFJbV8MWdlFTmj7dTvyvbWjrwfahj/CAuU8E5LULvkd4iuQd+68pChg6jTSZAiGBQjkd82gXvA2NV5XmHY9mxPcUnNInrP6Zcfhhu0b94BuVPjYJHO4nNB6Fgz6OoNFuUJ4PFgRkYihj0VMkIwdpI7KaLoQN9J0WWqIb42i4+zG2DhR4oLKMV9ZciAtnZl86wHwp0GaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrvLxx6HpizIt/WHf0QqyUTt+inDiIf1H0EF5thGIJM=;
 b=tWGs5f+6W3oLcB2GxxUF4TGOdL0j1oZ/+bEQT3Rz0cDnvdgk6bYczxqVOJr4e7pSwF1Zvb5mS85RkqXDF63qIhVahyfps3zvM8x/t2OFfeCAcElBJFSoEYYeu1fXUUgRswFwRjMZBkbNhrfA1EYk7PXFUQRvajoP3P/y6evhzH0=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB2968.namprd10.prod.outlook.com (2603:10b6:a03:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Sun, 18 Jul
 2021 23:00:05 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4331.026; Sun, 18 Jul 2021
 23:00:05 +0000
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
From:   Shoaib Rao <rao.shoaib@oracle.com>
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
Message-ID: <2b8a485d-d9bb-1579-613c-c32f580f3f2a@oracle.com>
Date:   Sun, 18 Jul 2021 16:00:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <74c62daa-9f20-cb51-ff6a-fb7def78b444@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN6PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:805:f2::30) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::b3] (2606:b400:8301:1010::16aa) by SN6PR04CA0089.namprd04.prod.outlook.com (2603:10b6:805:f2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 23:00:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 350e8fbd-f3d0-4354-f298-08d94a3fc836
X-MS-TrafficTypeDiagnostic: BYAPR10MB2968:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2968CA84932CA860349D3C55EFE09@BYAPR10MB2968.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhY7/ntbmUKiXZNV28wzS2gAa2/zeN1HCbdhDAFkyt1D2bEHlP/nwjCkyypRYsV2RCKQ/8NCN8GBw500ge71kfuMwO3zn/aTwQuM+uXlVO+deUX5W5Ti1RVk3EevChnifNpzouT59dbbXuI78myAJqCDyYAjdctkf+MAkqcOegLsZv4bdHZqKlaV7ESwLp7vVy1szRNl4rMMj6KRRiskkXyqd/aEFmzo6zGUkZRo4FARlTvvgIpQJzFHpT+vjVJe8erc0J7mRhomqrjm5HIATx25t2dOamgDoielPUQzCHg6jx61FpUwspSQImljV9v14JiVtEy77Z9IB2+9JaY/amVJs9X8fjb3iuGRntrRruAqy7VjL2Y9qqShWSQPcKMXVMowjG5113/Anxw0q80ffVQL4iqoXRdZs6b29VH2OgB9TxrDAUlL3eGHyAFiFHG6plP4UZ/JQIHHMlHimw4A3BPFUrdbALf5rxF/7ipHbMELzfEQtGAprbScBWMHt1ovIkkFDMncu11bVe++X20m9aWmDJFkONSx2LatJTyBgq9guiSk5L/frBHaPrKoDycSO9VnSdfkd0YcQjPmURh0M6fZ0/6s4Qd1LydiHzAbj8K3wzBL489vEe/YPt8bv/SfQc98Gox0QgQuA+O+M8PxaUO2+FjJJh1LfPkHtYFlIoLjRZa9pyI/P4jLc4Ms0SI6CIg4gzWTiVz2xLMNzuixVy/ey9Hcf7bbUxBrkavnzDksXSs//ldfUtbZM9g85bLh0oBwdGxHskRQukT+my17irASUlllbmhesw592KSg3HNH/I9SB6vbK7qxqNENcxBI3KqzgdiAtT+UjfMBSpEbHtlS0znrFaKL4J1FtAP9qjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(366004)(39860400002)(376002)(186003)(31686004)(966005)(478600001)(54906003)(36756003)(6916009)(66556008)(66476007)(66946007)(38100700002)(8936002)(8676002)(2616005)(86362001)(4326008)(5660300002)(316002)(53546011)(31696002)(6486002)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUZqcXNDTzIrZVpVeVdEbnFMMTdMblQ3eWROYVZlKzZ5cUNRUW16a0QvSTVO?=
 =?utf-8?B?V0ZVZG5rSEVVMm55MjN6MkY5Z1djb2tTYTJ0RnB3amNJbXhON0k4d09naENW?=
 =?utf-8?B?dDF6aHM3VzQyTE4yaFhUU1Y4Q2Y0R0NwVTBLR1NsSURQcVhud1c4ZzRWelhK?=
 =?utf-8?B?ZGJoZDFDdGNjUHBBWFBqNGxGelliOEpYMTdoVlVyWXVZYzBubGMrSEdEOGxq?=
 =?utf-8?B?anByVWZuL2cyWUUwSW0vL0svenVobERNbmlPcHp1d0liZmJ5MFBNdVFDMEhO?=
 =?utf-8?B?KzJjNFB0MmxacS94QlRjcTd1clJ0ZnBVK2RhN2tuemhNT25hdVNRYkFOcHZP?=
 =?utf-8?B?a3hDUW9HUk5OU045L2VZZEJYN2cwMHVCY01iRXBsdG5jaUxxZVdpdVdhTU1Q?=
 =?utf-8?B?dldwdFJTbUhta0hSRTN5UDFQOTl3aWgvNGhlSGgyVmFtVGpnQVRaWG1ZTThZ?=
 =?utf-8?B?U3RYYThSeVVodTBGRjlha2lJVjExa1E2SWRTd1JORHBNcnJYQ1JiUjZiNGJQ?=
 =?utf-8?B?S0R2TnpnWHR5bmJuWUZPTFNCWVhFczBxVzU4OGRDa3U4cXRJa2VGcTVuTE9m?=
 =?utf-8?B?UXlKaHVqT0Z0bTVNdGkxaEZJRWNjeFc0UEZiUm9wZytZam15cDNBYmtQd1FE?=
 =?utf-8?B?bnVHMHBUMXRmbUtHNWZxOENYWWRiaEdLcnZwcTY3U1ltaWV3MTl4aFdGTnY5?=
 =?utf-8?B?UjQyYVpXcjFJNTBlb1pWUWNEQmlKbC9kNnU2dENta1Zxc0VPTThxL3k2cGxl?=
 =?utf-8?B?K0xpYk5KUGN3UEdXU1hWU2dFSnJnWVFETGRnMXZVUlJnN0tPMDA0WmtBZEtv?=
 =?utf-8?B?dm52TElZVjlJalMwa085K0xrQkpoNkE3eExlUStXUmxBQzZzSEQ3RmpZSHFJ?=
 =?utf-8?B?MlBjWUFjaHJSeThXRWJYOVZ3L003bWh3dHhqZ2pkVENGOXcvWlFPb0RYeGZZ?=
 =?utf-8?B?UVNYb0I4elp2TUhsL3ZaRDhGb3NVODI0S0FLaDFKRE1OL0xlM0hRY0YyVWVw?=
 =?utf-8?B?amhrbU9RSXUwSmVEd0pIU2tLbHB6YTJRNDYrUGRPYUVmZi9LNHgvcXhxOGRK?=
 =?utf-8?B?OXVqbUhVaUpLb3N5emtwWHR6VmJGRkM4K2FjbzJ0cWo1K0YyWHpQbWczbVZ0?=
 =?utf-8?B?NktiMGlaWWhoZjhFTDNybzBoZWFHYXhaaFNSbHYxenlvb0xNQXh1TEZGajVa?=
 =?utf-8?B?OXQ4cW9qMVZlY3VML1h2RThMRStpY3dUTUFwRUpPTThRTDVFbGJQbmVUSGhJ?=
 =?utf-8?B?OHNDb2hSaEF1VFBzVEdhb29KK2haWldQU0JUQzJEeVlnREtRODNiUFJ4aTA5?=
 =?utf-8?B?ckpsR0I3ZitxR0w3dld0a0xjWDM3Wkl6ejJGSmFwbVFkaWdhbG1EK0l3VTly?=
 =?utf-8?B?SzdtSzRhTmRvUDh4ZklMV29VWmx4SWs4eTV5NXV4c1VPdm9aVmpDZ2cxZ3VI?=
 =?utf-8?B?TURvQ3NrL05CcFlEblFpUE82ek1tUytrbmtFd1dwcmpkUER0K0ZUN1lJTCtX?=
 =?utf-8?B?bGh3MkdFVGEyZGdHMXRCTnc4c05ySVViS2t3Z0JMUENIRW1JSTFMUWhBQW03?=
 =?utf-8?B?bUdoRGNhZjdTWVlUOTc2cHFLVnRDNDVGYkJzWjFwQTZaVlVwTnRXQW8vZVlt?=
 =?utf-8?B?SDkzU3FZZzV5QmNzL25wbVRBTzZNdXJTamJxR2F1c01MU1FmM0JKMHo2eE44?=
 =?utf-8?B?V3ZJZkY4M2tDSEMrbUkwOUR5Z09YUDExeWRWODFMbVlrTGlyOXUwZkUwTmgr?=
 =?utf-8?B?NFBJQ3BmQ0lEQnV3WXFFcVErWCt5bW9QMVozSFFSb3hkY3c2RzEzOXZFazFQ?=
 =?utf-8?Q?2o2BawtAm/CQmlrSNgu5TU8WkXfNKo60O/cK4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350e8fbd-f3d0-4354-f298-08d94a3fc836
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 23:00:05.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nXoFpiKQ5TjLfJWZJmPz6/iW/w8Hffqn7ppRP7Sj6Mky7XJdM58R5q9/mk1KAp0CYrfYAG/YrSKPoi06+VbVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2968
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107180156
X-Proofpoint-GUID: gx2wmS2dI8nrXA5F1SxQR1_-t0UuZ1xs
X-Proofpoint-ORIG-GUID: gx2wmS2dI8nrXA5F1SxQR1_-t0UuZ1xs
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks for reporting the issue. I was able to reproduce the issue and 
have fixed it. Kindly try gain.

Regards,

Shoaib


On 7/18/21 12:46 PM, Shoaib Rao wrote:
> Your urls are garbled, so I can not make any sense out of them.
>
> [root@ca-dev141 linux]# git remote --v
> origin 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> (fetch)
> origin 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (push)
>
> [root@ca-dev141 linux]# git show 8c1b4316c3fa
> fatal: ambiguous argument '8c1b4316c3fa': unknown revision or path not 
> in the working tree.
>
> [root@ca-dev141 linux]# git log --grep='RDMA/efa: Split hardware'
> [root@ca-dev141 linux]#
>
> [root@ca-dev141 linux]# git describe
> v5.14-rc1-17-gc06676b5953b
>
> You need to do a little bit more work on your end and tell me which 
> value rxe is complaining about. Also provide a kernel version that you 
> are using as I have provided above.
>
> Shoaib
>
> On 7/18/21 12:59 AM, Zhu Yanjun wrote:
>> On Sat, Jul 17, 2021 at 2:09 AM Shoaib Rao <rao.shoaib@oracle.com> 
>> wrote:
>>>
>>> On 7/15/21 9:07 PM, Zhu Yanjun wrote:
>>>
>>> On Fri, Jul 16, 2021 at 12:44 AM Shoaib Rao <rao.shoaib@oracle.com> 
>>> wrote:
>>>
>>> Following is a link
>>>
>>> https://urldefense.com/v3/__https://marc.info/?l=linux-rdma&m=162395437604846&w=2__;!!ACWV5N9M2RV99hQ!f9TPWtgUxambtSeQ_L3h-IH7CW3SifyiumB3kjc2v_w6Ec_WYVtjWyusEtgQ60iw$ 
>>>
>>>
>>> Or just search for my name in the archive.
>>>
>>> Do you see any issues with this value?
>>>
>>> After this commit is applied, I confronted the following problem
>>> "
>>> [  639.943561] rdma_rxe: unloaded
>>> [  679.717143] rdma_rxe: loaded
>>> [  691.721055] rdma_rxe: not enough indices for max_elem
>>> "
>>> Not sure if this problem is introduced by this commit. Please help to
>>> check this problem.
>>> Thanks a lot.
>>>
>>> Zhu Yanjun
>>>
>>> I do not see the issue.
>>>
>>> [root@ca-dev66 rxe]# lsmod | grep rdma_rxe
>>> rdma_rxe              126976  0
>>> ip6_udp_tunnel         16384  1 rdma_rxe
>>> udp_tunnel             20480  1 rdma_rxe
>>> ib_uverbs             147456  3 rdma_rxe,rdma_ucm,mlx5_ib
>>> ib_core               364544  10 
>>> rdma_cm,ib_ipoib,rdma_rxe,rds_rdma,iw_cm,ib_umad,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
>>>
>>> I am using gdb to dump the values
>>>
>>> (gdb) ptype RXE_MAX_INLINE_DATA
>>> type = enum rxe_device_param {RXE_MAX_MR_SIZE = -1,
>>>      RXE_PAGE_SIZE_CAP = 4294963200, RXE_MAX_QP_WR = 1048576,
>>>      RXE_DEVICE_CAP_FLAGS = 137466362998, RXE_MAX_SGE = 32,
>>>      RXE_MAX_WQE_SIZE = 720, RXE_MAX_INLINE_DATA = 512, 
>>> RXE_MAX_SGE_RD = 32,
>>>      RXE_MAX_CQ = 1048576, RXE_MAX_LOG_CQE = 15, RXE_MAX_PD = 1048576,
>>>      RXE_MAX_QP_RD_ATOM = 128, RXE_MAX_RES_RD_ATOM = 258048,
>>>      RXE_MAX_QP_INIT_RD_ATOM = 128, RXE_MAX_MCAST_GRP = 8192,
>>>      RXE_MAX_MCAST_QP_ATTACH = 56, RXE_MAX_TOT_MCAST_QP_ATTACH = 
>>> 458752,
>>>      RXE_MAX_AH = 1048576, RXE_MAX_SRQ_WR = 1048576, RXE_MIN_SRQ_WR 
>>> = 1,
>>>      RXE_MAX_SRQ_SGE = 27, RXE_MIN_SRQ_SGE = 1,
>>>      RXE_MAX_FMR_PAGE_LIST_LEN = 512, RXE_MAX_PKEYS = 64,
>>>      RXE_LOCAL_CA_ACK_DELAY = 15, RXE_MAX_UCONTEXT = 1048576, 
>>> RXE_NUM_PORT = 1,
>>>      RXE_MAX_QP = 1048576, RXE_MIN_QP_INDEX = 16, RXE_MAX_QP_INDEX = 
>>> 262144,
>>>      RXE_MAX_SRQ = 1048576, RXE_MIN_SRQ_INDEX = 131073,
>>>      RXE_MAX_SRQ_INDEX = 262144, RXE_MAX_MR = 1048576, RXE_MAX_MW = 
>>> 4096,
>>>      RXE_MIN_MR_INDEX = 1, RXE_MAX_MR_INDEX = 262144, 
>>> RXE_MIN_MW_INDEX = 65537,
>>>      RXE_MAX_MW_INDEX = 131072, RXE_MAX_PKT_PER_ACK = 64,
>>>      RXE_MAX_UNACKED_PSNS = 128, RXE_INFLIGHT_SKBS_PER_QP_HIGH = 64,
>>>      RXE_INFLIGHT_SKBS_PER_QP_LOW = 16, RXE_NSEC_ARB_TIMER_DELAY = 200,
>>>      RXE_VENDOR_ID = 16777215}
>>>
>>> It is possible that you are changing some values.
>>
>> I git clone the source code from
>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git__;!!ACWV5N9M2RV99hQ!efPsL9fikzm6Ob1-zsmbsAzPkfqRpxYkp9oJXF9csPOJgoei9njj8RmA5IyuH447$ 
>> again.
>> And the first 3 commits are as below. One is your commit.
>> "
>> 6163ad3208c8 (HEAD -> for-next) RDMA/rxe: Bump up default maximum
>> values used via uverbs
>> 8c1b4316c3fa (origin/for-next, origin/HEAD) RDMA/efa: Split hardware
>> stats to device and port stats
>> 916071185b17 MAINTAINERS: Update maintainers of HiSilicon RoCE
>> "
>>
>> And when I tried to add a new rxe0,
>> "
>> error: Invalid argument
>> "
>> And the dmesg logs are as below:
>>
>> # dmesg
>> "
>> [   70.782302] e1000: enp0s8 NIC Link is Up 1000 Mbps Full Duplex,
>> Flow Control: RX
>> [   70.782744] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s8: link becomes ready
>> [   79.467652] rdma_rxe: loaded
>> [   79.468348] rdma_rxe: not enough indices for max_elem
>> [   79.468356] rdma_rxe: failed to add enp0s8
>> "
>>
>> Please follow my steps to reproduce this problem again.
>>
>> Zhu Yanjun
>>
>>> Shoaib
>>>
>>> Shoaib
>>>
>>> On 7/14/21 10:02 PM, Zhu Yanjun wrote:
>>>
>>> On Wed, Jul 14, 2021 at 4:36 PM Rao Shoaib <Rao.Shoaib@oracle.com> 
>>> wrote:
>>>
>>> From: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
>>>
>>> In our internal testing we have found that the
>>> current maximum are too smalls. Ideally there should
>>> be no limits but currently maximum values are reported
>>> via ibv_query_device, so we have to keep maximum values
>>> but they have been made suffiently large.
>>>
>>> Resubmitting after fixing an issue reported by test robot.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> Signed-off-by: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_param.h | 26 
>>> ++++++++++++++------------
>>>    1 file changed, 14 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h 
>>> b/drivers/infiniband/sw/rxe/rxe_param.h
>>> index 742e6ec93686..092dbff890f2 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>>> @@ -9,6 +9,8 @@
>>>
>>>    #include <uapi/rdma/rdma_user_rxe.h>
>>>
>>> +#define DEFAULT_MAX_VALUE (1 << 20)
>>>
>>> Can you let me know the link in which the above value is discussed?
>>>
>>> Thanks,
>>> Zhu Yanjun
>>>
>>> +
>>>    static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
>>>    {
>>>           if (mtu < 256)
>>> @@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int 
>>> mtu)
>>>    enum rxe_device_param {
>>>           RXE_MAX_MR_SIZE                 = -1ull,
>>>           RXE_PAGE_SIZE_CAP               = 0xfffff000,
>>> -       RXE_MAX_QP_WR                   = 0x4000,
>>> +       RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
>>>           RXE_DEVICE_CAP_FLAGS            = IB_DEVICE_BAD_PKEY_CNTR
>>>                                           | IB_DEVICE_BAD_QKEY_CNTR
>>>                                           | IB_DEVICE_AUTO_PATH_MIG
>>> @@ -58,40 +60,40 @@ enum rxe_device_param {
>>>           RXE_MAX_INLINE_DATA             = RXE_MAX_WQE_SIZE -
>>>                                             sizeof(struct 
>>> rxe_send_wqe),
>>>           RXE_MAX_SGE_RD                  = 32,
>>> -       RXE_MAX_CQ                      = 16384,
>>> +       RXE_MAX_CQ                      = DEFAULT_MAX_VALUE,
>>>           RXE_MAX_LOG_CQE                 = 15,
>>> -       RXE_MAX_PD                      = 0x7ffc,
>>> +       RXE_MAX_PD                      = DEFAULT_MAX_VALUE,
>>>           RXE_MAX_QP_RD_ATOM              = 128,
>>>           RXE_MAX_RES_RD_ATOM             = 0x3f000,
>>>           RXE_MAX_QP_INIT_RD_ATOM         = 128,
>>>           RXE_MAX_MCAST_GRP               = 8192,
>>>           RXE_MAX_MCAST_QP_ATTACH         = 56,
>>>           RXE_MAX_TOT_MCAST_QP_ATTACH     = 0x70000,
>>> -       RXE_MAX_AH                      = 100,
>>> -       RXE_MAX_SRQ_WR                  = 0x4000,
>>> +       RXE_MAX_AH                      = DEFAULT_MAX_VALUE,
>>> +       RXE_MAX_SRQ_WR                  = DEFAULT_MAX_VALUE,
>>>           RXE_MIN_SRQ_WR                  = 1,
>>>           RXE_MAX_SRQ_SGE                 = 27,
>>>           RXE_MIN_SRQ_SGE                 = 1,
>>>           RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
>>> -       RXE_MAX_PKEYS                   = 1,
>>> +       RXE_MAX_PKEYS                   = 64,
>>>           RXE_LOCAL_CA_ACK_DELAY          = 15,
>>>
>>> -       RXE_MAX_UCONTEXT                = 512,
>>> +       RXE_MAX_UCONTEXT                = DEFAULT_MAX_VALUE,
>>>
>>>           RXE_NUM_PORT                    = 1,
>>>
>>> -       RXE_MAX_QP                      = 0x10000,
>>> +       RXE_MAX_QP                      = DEFAULT_MAX_VALUE,
>>>           RXE_MIN_QP_INDEX                = 16,
>>> -       RXE_MAX_QP_INDEX                = 0x00020000,
>>> +       RXE_MAX_QP_INDEX                = 0x00040000,
>>>
>>> -       RXE_MAX_SRQ                     = 0x00001000,
>>> +       RXE_MAX_SRQ                     = DEFAULT_MAX_VALUE,
>>>           RXE_MIN_SRQ_INDEX               = 0x00020001,
>>>           RXE_MAX_SRQ_INDEX               = 0x00040000,
>>>
>>> -       RXE_MAX_MR                      = 0x00001000,
>>> +       RXE_MAX_MR                      = DEFAULT_MAX_VALUE,
>>>           RXE_MAX_MW                      = 0x00001000,
>>>           RXE_MIN_MR_INDEX                = 0x00000001,
>>> -       RXE_MAX_MR_INDEX                = 0x00010000,
>>> +       RXE_MAX_MR_INDEX                = 0x00040000,
>>>           RXE_MIN_MW_INDEX                = 0x00010001,
>>>           RXE_MAX_MW_INDEX                = 0x00020000,
>>>
>>> -- 
>>> 2.27.0
>>>
