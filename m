Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB663DADA7
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 22:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhG2Ud4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 16:33:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2378 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhG2Udw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 16:33:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TKGRGu012647;
        Thu, 29 Jul 2021 20:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eW6Y/1V55t/G/FXFc+OQPD6P3gHrHSMlbqzC7r8V+Ag=;
 b=bQakTdDJ65s5KOwnNCqF6PlqGVXevb7TqXvwEDJ2UI2gg2Xxqrx5BaS9Q8+zDpPfV0GI
 K4e5xVV8EUto96matYDdn6PQEDnb1iJY4CqWh3Mx0Z+Z/OR5DusTG25e/0WfbDJuzN8k
 120g6ppHdqab5c9+PgBB5IHpbnTUPFPD96YyCzkQAuMAZ4ugDuWV0JjnBoJL+uGE35PN
 088FkIPYxt+T+Q4v07seN+uqoDBwieFKCUfSHES+kLRPAweUia6lFkuWl/F0xiRTLR3g
 w2d3a7JiZjZBJR446hvqF53vPiStz2w8mAfnPOqLLbcMGrke7jsFADEeOVLqzN47oSbS RQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eW6Y/1V55t/G/FXFc+OQPD6P3gHrHSMlbqzC7r8V+Ag=;
 b=UyerT+jkOsnTH3ervBxTPVsdjFi8D7QiWKcPN0b1hyUmKyy4wklAz8UWJcNEIK+7kZcg
 c0DA74YxbLFtw2xwEbtjO8gBGT1j+DzgwbSSR9Q1UycGpFe8XLSlnpHMH0/3PE4zUVpD
 g4Szrfl3j209FNwxmQMvcy+Lz33Ri1XA0inUehvsxEFB+rZ5bijTctIhq6xU+BsvKAKT
 s6WDqu0FG74QQL3wffjyGPD/KAxm4dOBsgU0j2P3XfpJhPRrCpAVhAtGce1hF3moA385
 1g6sThpcsS1Z+pnkj8mg7PA4MtLaWiWWV9stdRQM0JoA1QMpMRnRlNz9L1HW91SNMZ7T lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a3qj4sv9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 20:33:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16TKFd4T036982;
        Thu, 29 Jul 2021 20:33:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3a234cxyr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 20:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7bhit62OXJoqmSrgIhgx4wFAchp3OKEs2/ppjvwtBoegZU3uUBIwYQFp0Amsl0OXtn10mO7QnenKAPtw2xXzfJdWY281ilczRABmWAXfwxs6DOo/sTMOfwCKWQHmTPPWfnUCiisvtw9xK7lG7KxPvxVNyyLGCWMjsm54dV4UEpGmX2oCqKL9uiBJIcr69miB9P4bD5//51Eh+ytmOOJcvf0MvGRuX8D+UJSM5WCBnch9DWqOnHkQFDHD5QUsrqtYwXhY2ZIZOmsM75ZY7s1DRooguLEeNts9Hr7oZoz7+eZVajRm4zrTVpCXS9ZcKnA12kbeDPgu9OezOZpih3ZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW6Y/1V55t/G/FXFc+OQPD6P3gHrHSMlbqzC7r8V+Ag=;
 b=XW65V2DIRKoL7rZ5oYOKvEvyyDL4eJSkx3pAGze25M90o2DyGgRb4z/XW3LLL8cbUtyQf0q+dmX+xriztS8j0a15ay3GweL3Lsl8/rMFL0rQd7ie53yLcDi77w0/t/BKtDGOlHx/esgDYYTo+Td4ldUpS2eLETfqeoj2jCycflYaqf3cMq5roGA0XrDVJU/p/exaDGctt2TbEhh/M28PC69SlYcR8EnL39vj8Q68HhlqZBBeazbYFEHb/L9J7LHEyV9w1eFm3IsTpgGEiLY125pG0UuAJqdzP6vjtTkq6k2fY1IoKMtqjmm5U4VdxNoboqNZuutyqpic2cCZ+Ql83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW6Y/1V55t/G/FXFc+OQPD6P3gHrHSMlbqzC7r8V+Ag=;
 b=ZpGl91iEXEa+VAs19q3KgtFMDFRJskFvVhtKPyvyMhYMsoGyj4avGDFdEjQiJ1+YMtWW+rl+MJG48zU7HU5xC8RDNiWj3KnHeCT5nKmZ8ToGL9p+1UhFcQ1WwhlBi8/YZA8Fup1OL+v3GiiMOlCi2l/TRzyOo9tUNRvpXuxxh28=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB2645.namprd10.prod.outlook.com (2603:10b6:a02:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Thu, 29 Jul
 2021 20:33:44 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 20:33:44 +0000
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <6e99e37d-2476-21ab-0584-6f4b12982b9d@oracle.com>
Date:   Thu, 29 Jul 2021 13:33:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210729195034.GF543798@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN6PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:805:106::28) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::4a6] (2606:b400:8301:1010::16aa) by SN6PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:805:106::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.2 via Frontend Transport; Thu, 29 Jul 2021 20:33:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b86c109-bfe0-43af-79db-08d952d02923
X-MS-TrafficTypeDiagnostic: BYAPR10MB2645:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2645F7552BCDC0B05ABE13A7EFEB9@BYAPR10MB2645.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UipGaOE58SHQVrpovh9y88/PK6LYa8Am/OWn3gZo1m1q24rztwU1B8wOY4tyzcJjIDmegEfv62G9PtAih/tkGdoZLWQwliHaEWP9OEVj1THsENqnfqSCyJbdgi1dLq509WLSehzNdU+OHg/L17NOXN2Gd1nzhm/F5XEWmcEgUeKeS1FbF9i5pGMVv7LICSaI+UlhN6pXglluk+Drp3WFZPqc/hQVhkNZsn39jerSF4CY4xblblasu/VYn8uU3CZH6zqzRD5EK8TVNvIfD0vWIKOkBZlQcq1S7PfeOmb3x57/CpiMczbBzcwu0ZFPaEvi2WtdpIbw9vLpc50ms6HQsuI1iWVEPIwCh2+8ZA5HjY3Zf5hGgcmLhgAvbQy6EvF9ArqlImTEhrJiIl54mm6rZWwrBwMd751usW6ozDnqqWOTVKjMUuHbAMannfPk8Ygifxwt3qOncKZewE4cqtWVyAeDrovOCDYYMB/RifKq/+6GSHLPPrYyEFWD/BcY6iSHLCiO64XlyQ0mECj2Avs2VSWye8DBgsOZuGwJ36OpYiVvZRQlUd7N+w6WqTBpNIWqJzlbGPmCZ68Zq4nqJA4XkX3ua5P2hc6cMdFG4sWuyxPxAizWYbV8oA41P88yNe0qbeHCSH6M2fd//8Y71ePWAY1Kj0ITf5gp3E1ecbfqlwtaNSMlxyqgDBgQvWyB3NOmGYBMiDVZXTNBKsiHgnTK8AVAHmnJvyYj4JVJb/jP6IM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(346002)(136003)(31696002)(31686004)(186003)(4326008)(36756003)(53546011)(38100700002)(8936002)(6486002)(5660300002)(2616005)(66946007)(54906003)(6916009)(8676002)(316002)(66476007)(2906002)(86362001)(66556008)(478600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEcvTlVVMmNlYnlFTS91MHBkNXN6dDIyQjd2Q1lsWlcycDRRZHdjTmdXa05j?=
 =?utf-8?B?WXkwRmo2Nmd3NVM4NnZJL3RYdWhlb2MvVVlrSjlJZC81QVRiOTFyc0N6SGJa?=
 =?utf-8?B?SENCMDNTYm5kaW9MWElBb2M0YXBhdVJ5cS9EK3BwNTRxeVBqZGZGYzM3Vmxn?=
 =?utf-8?B?akQ2RDlwemhZUmhvc21TaHhwWGh0eFNCT1FKSlZkY20vc21oTno5dmpsZ1Jm?=
 =?utf-8?B?TFJPV3paNWg5Q1kwQlNOTFNTMGJkMXNGS0JxSWU5U1NuVzlhdHFYUE5tN3dB?=
 =?utf-8?B?eWJBbkhhUlNxU045RnpvMzRQN3B3Unc3cGJRRC9vV3NqMGRweFBZR2M5VC9h?=
 =?utf-8?B?UE1xSUZuYlNDNGlscXlyNWhkQUE2NjQvMGFMMVJZaFVnaENIQ1lZL21xOGNK?=
 =?utf-8?B?THI3RDA1aDkzRk9kSlRYakpDcS9HMXlBL3pxYTcrSkhkS2VoTGwxbmd4dU5i?=
 =?utf-8?B?c0N3SkhZaTFlZThyNGw0NFE2ZURZSDN2bjlXYWI4eEk4aEhmS0IzeWF0THhE?=
 =?utf-8?B?QkgrS1ZVaCt4eit6U05PcWhYSnJIQTRZL25nSVhCTnVTdG9OK0MzZGl4dEo5?=
 =?utf-8?B?anNCN1lyQkdrRmpmN2pvMHI4K3ZOL3ZWRGkwZVovRjRnMktUL084YjQvSFNE?=
 =?utf-8?B?L3B6VXliWUZuVmZodmJpakFEbHJZRHJnL2FPZWtVL3F4UzJSbkVPYmlwZnhy?=
 =?utf-8?B?MGJQMW5lSkorcm1nbnBvWGUyWnZ5a29EYmJkUldRM09UTU00ak0rV3NDLzN5?=
 =?utf-8?B?SnhWVEUvZThId0FkcGZpUUY2d1pSNXJQVGY5R1NzUCtZeGlJUG5NNnA2eVFG?=
 =?utf-8?B?cjh6R3F1RWZSUzJMUi8vc0M4eGE5VHlaWEVlTS9VOUdSWDh4RGVKbE1wVFBD?=
 =?utf-8?B?SGxST2JZTlp1bm1OdFZ6MmIySG1BK3hFazdvVFQ3MWFlTUszVE55RGxheGFt?=
 =?utf-8?B?Z1g4NUVtNXRyM2ZjUnVrejFRd0RDQVk0T0RtMURTQkZzZW9JWXE3US9mT3dv?=
 =?utf-8?B?dS9zQTVURFRUZjdNTmZsbzdRQ0RtYVRNeFBaVUZ2VHpqYk5BblpFZndGa083?=
 =?utf-8?B?aWdhZkZZNGcwTm5KdFJNeXloVlQ3WU9rcU02Q3NqUVBKRDRISnVuNlBONTl0?=
 =?utf-8?B?MUZIdzlZRzZDZEJaMFMvdjJTYVlYZ055YWRyakpoUGREeTJhOWU1SGhYNmtT?=
 =?utf-8?B?K2M5N00ySS9RNzNONWVXYjZSdmpiQm9FYzg1cVFxSzhHTzNzTFZxS0YzazZm?=
 =?utf-8?B?dXBPVE5CMFRub1EyRUZJZFJ3VTZidVhWWjdLQ2FKTzBWZWpzYXBJMTBYL2No?=
 =?utf-8?B?T1Z3cWtTOFgrQjJnMzN2VE1nVFJuOUd0UHQzWHd4dnBydVNJOFVvOFpPWThP?=
 =?utf-8?B?VllzSUhTK3M3RzBHYUt6Qzd0UUpBMVhLbXNEa2hsSHBuWUk5Tk1IVXpGZjA1?=
 =?utf-8?B?b3Z1dHhEdENaL0V6Z1lHeldMUU13WFNFRzhZbDhKM28vZU41R2FqbERNMHdk?=
 =?utf-8?B?dlNUWVVsU2EzTU5NY0JhVTlHemJ3NHFCSmJna3l0ZDZsSllRUWJjaDkyNm04?=
 =?utf-8?B?S0NoQnpUZHVidTVyZmZxRmNPSlpDTklUbHArNmtibGJYVlFQVDlicFJoV3Ax?=
 =?utf-8?B?eXdUVmZhTWNPZXBnMktxZC96VmlGeC9kUGtWZ0tUQWV3VzZUTDFXajAxM3dt?=
 =?utf-8?B?eittcHhoUEhVZ2VJZURuUTVweVdCazh0UVVSZmN3QTFScmxZUHpTeWNuck1H?=
 =?utf-8?B?N09TRlFWNFhoZVU4cWtvbTVEMUJZNngwQXhjNUNSVGZ0Z2hLN1NDNGl1UGJi?=
 =?utf-8?B?OFdGeUhYUWN1T3ZTVnVKZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b86c109-bfe0-43af-79db-08d952d02923
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:33:44.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtpAvEkAVAo8hcVglXz1s8x+GTfoVdLX+ck6YLOmAgVBf/C1iSVs+mU7eZDGNY5GxPwvxcZbGDbWmFWi3fOQmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2645
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10060 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107290125
X-Proofpoint-ORIG-GUID: qI-zULvd2MLOnTLFUor0eO1oSW_l_RED
X-Proofpoint-GUID: qI-zULvd2MLOnTLFUor0eO1oSW_l_RED
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 7/29/21 12:50 PM, Jason Gunthorpe wrote:
> On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:
>
>> Can we please accept my initial patch where I bumped up the values of a few
>> parameters. We have extensively tested with those values. I will try to
>> resolve CRC errors and panic and make changes to other tuneables later?
> I think Bob posted something for the icrc issues already
>
> Please try to work in a sane fashion, rxe shouldn't be left broken
> with so many people apparently interested in it??

I agree with what you are saying and I plan to help address the issue.

For the record, I just tested my changes on a 5.13.6 kernel and they work.

[root@ca-dev14 ~]# rping -s  -a 10.129.135.23
server DISCONNECT EVENT...
wait for RDMA_READ_ADV state 10
[root@ca-dev14 ~]# uname -a
Linux ca-dev14.us.oracle.com 5.13.0-rc6_rxe_defaults+ #1 SMP Thu Jul 29 
12:48:41 PDT 2021 x86_64 x86_64 x86_64 GNU/Linux

[root@ca-dev13 ~]# rping -c -a 10.129.135.23 -C 10 -v
ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
ping data: rdma-ping-1: BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrs
ping data: rdma-ping-2: CDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrst
ping data: rdma-ping-3: DEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu
ping data: rdma-ping-4: EFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuv
ping data: rdma-ping-5: FGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvw
ping data: rdma-ping-6: GHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwx
ping data: rdma-ping-7: HIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxy
ping data: rdma-ping-8: IJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
ping data: rdma-ping-9: JKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyzA
[root@ca-dev13 ~]# uname -a
Linux ca-dev13.us.oracle.com 5.13.0-rc6_rxe_defaults+ #1 SMP Thu Jul 29 
12:48:41 PDT 2021 x86_64 x86_64 x86_64 GNU/Linux

Shoaib

>
> Jason
