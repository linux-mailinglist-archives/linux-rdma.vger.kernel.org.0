Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541FB3DF965
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 03:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhHDBvp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 21:51:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45660 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229820AbhHDBvo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Aug 2021 21:51:44 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1741mSdi019948;
        Wed, 4 Aug 2021 01:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ysashAzSWcLoIs45RE3O8esfhDElbNVDOTS1Ehp0N8Q=;
 b=SkxJlqwOVQhk1lUA9FOK6T0tOt+eOw6Kjs5mDKx1+Texk0qtMGMWjn2W84N9IJz0AhLA
 GJsdtLyXnrpMY4DNnI/jhfg86Tu8uB0mYmb3tYi+sRGnhJDMDcAi+m0teblhJZShByCA
 QMyucLB4TrOgSEpK679B2kDc/+tVbnCeqaHQ5/evlRtJAc8qrmtwgLP8+bgFWj1i1CWj
 UR/36lcBo41pzZ+EYly6yOAyYmTXif64xvS3qR81Vv0Um6UkhfSOfAgV5fou40hHT6D5
 JIA1b8kj7rp2w8KrbV6Z50ENIo0PFGJVXGi2F3Y7rk0QsvOAx66e3ketltqWobJ3n0Cp 0A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ysashAzSWcLoIs45RE3O8esfhDElbNVDOTS1Ehp0N8Q=;
 b=RIIDkawciwGhWpFy8o9to8CEfQdZy2IEBvxJ0uLCy1ALuIEamFpeiEgbUdxd1EuxwVTY
 t4O8WseOTk52zlWmriEKPqwZbOspzEr9tvXujr9A2PqASj+AV0sSUEg4REeDD7oUbHZM
 Clk+S2LZ3eoPVpyWWiPDO6KbErVbjk18TtQotyZQKwXnVydN0pxhQZEzqpzBr2nFAuxC
 EWRZMM/j9mYdsOS5xrbI9YWMLJbwKbUdjeBh8/lhQ5yyXhtqieCjCBr5FC0NJjUheoTQ
 WBm7L0iVddKvbxNMdBEPGTk3t4xQEdILhAehz2+B2TeoHMoO2RWiT4B62d0Npj099g3B 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a70pjtjxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 01:51:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1741jQ4b185961;
        Wed, 4 Aug 2021 01:51:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3a4un0q47e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 01:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQxsk96RG26GIrrXc579v+ZtyJdyJgTe4NT2CVSDJCHf0PIrjImGyHYYG9WD3Ad3gCOjR8LQugxMeT4nWW9+h5WNvXqXDwxduqgSIWMKkHkTIpMo31wRGtpSJkkA+vsJgz2X+Y6FAQgyFEpXDD7GzRo1vtR/HGJ7I0huayGB+8n62UaLERM8UK9iG6Dx+5poMMXUVt+w/nfjL+vYS4qxz2CwxGRJB22M8wVf4WukI7mjTqmaxiILnYzMwei838cY5PkEPGCwAowsNjEXbsWpBXQzkFeNmhKrL7on8SI9hg0wcJoQGiR7YnVJ/T+NGj7uNdkMIKgm3tMX8t9VZaTJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysashAzSWcLoIs45RE3O8esfhDElbNVDOTS1Ehp0N8Q=;
 b=J5dlezHoIujD9v9Xjxf9WykoNNCBrK9HuzTyTS3QT+VFzWfBr+5MbVbMZ+qbTNm8MIHeTEjqyCmn7C7Adjj4f5jcr14JrkBESj8BNG02+b8JebdIG86yME2/HRQ0J8g2awTv0T5Oare4/NaojMs8U4mHEiQUjJatSXSLO5vkFf3mxd0ZeMqYmguO0qxU4ACms/PnPOgZKfpGfn950ubyWVYZsB98dLIdo/UPyeob+mykVwMkRNpZz2GxB2RjkaYSOeM1UWx+l+aNkZuN+a+8sYnFFoGwaWInaISpf57zefkKmgB8HYVLmVLNThCh7QYFi9DeS92UZW7uTDNKTEHdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysashAzSWcLoIs45RE3O8esfhDElbNVDOTS1Ehp0N8Q=;
 b=FekAg1DTEecqfc0X1Y4H2mk+lmBUZf/BFjmXPZK/ifizppu2dJjUkfKUEGr2W1KhsSTgg1AzxVh//kpJ9NPXTUDRiAvSt0j6mSrV81r2tLM7CPSy0+HQoCtaFkpCiO263KlNjKeQceGi3OWcTcafxqwDSctroTJoqCGGt7rk7DU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Wed, 4 Aug
 2021 01:51:27 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 01:51:27 +0000
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
 <14b9f35a-0086-834a-c05f-361a26befc13@oracle.com>
 <90ab34d4-92d1-986d-80e5-4253d208d073@oracle.com>
 <CAD=hENdFbF9VKhgLhSBomvQ7KvDFJhTNiPt-AfdWsKBVfo58MQ@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <7a1881c3-4955-5a24-7f90-4d60f2a607a8@oracle.com>
Date:   Tue, 3 Aug 2021 18:51:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAD=hENdFbF9VKhgLhSBomvQ7KvDFJhTNiPt-AfdWsKBVfo58MQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------2A026B630E59A2492243E40D"
Content-Language: en-US
X-ClientProxiedBy: SN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:805:ca::21) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::cb0] (2606:b400:8301:1010::16aa) by SN6PR16CA0044.namprd16.prod.outlook.com (2603:10b6:805:ca::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 01:51:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afee8e02-81fc-44c8-40d1-08d956ea5f7f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4623:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4623F00F77CA1BE2269443B8EFF19@SJ0PR10MB4623.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pb62QMA0lfHMHRd6lM2XKOb21hPGky2TRHmtutttgw+ZMaA+1WQIYzBQA9MM3kYFYW4oqEUs7SvlVEUqO+EfObcw1iS4Ivw7P3h5wOjZpktRmADXj5iCMxTUTsR8QsW5FZEUQVT5sb73aYNcwZy/vj/C63p4l2u3pmQrLMP3IC3Zc99pAa0lgiqitXyM5bZtGLg3kyLxK/i0Z4vtVreM6vuO+9NJKh7npCCoeWFb7GdX/AjAfPqa1mJ8GE3rJWXMbOuj824oV/07POcYcni1hGB8fsW1JuM8uX6Z6wguUrKqUNCvCTdDuWoyTQ0awpiwVRE2siURc/mwKUePsTgVS4JRWwyF4ncrWFuauHQOCMQRgOD1ONfNYlMfIxH0nVuKi9LaviJj8qycTcOtVhDET/+lk38/Z7Gtb9Y6E8wn9AYYRyPoCPbfullExZwyu/MrbExHunyaYazhdUzT7PTzHoYQvzSp1CeWF0p6DHGA8akdahyrxNd3U1i7+aaUoIIFaBIHUT6bc1sKeJIs70J1BJzvQ4kWukkqkCFOzvoaEFOvWEvS/TDrQ6NqCi3pfqFWYuHKYpdG84Hu1mMyeLZ4m2Bfaal09nL+DlLvCsLO0pbcOVT+CwkoDDTaamhO7tQYbPLluH7C2BkzCkAA9oaSm+YgrqnKNOo31RVxQXshPLM1AU/lqF/ZhrGJnam9/8hMPVr2UPABxfkR6rXRfcq2aAv/Y5rCTkqtOt5EbiuE8Wadq26HukA28RNWmp9MVoxZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(366004)(39860400002)(38100700002)(36756003)(66576008)(2906002)(8936002)(83380400001)(235185007)(4326008)(33964004)(31696002)(8676002)(5660300002)(6916009)(66556008)(53546011)(66476007)(478600001)(66946007)(6486002)(186003)(316002)(31686004)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhFWmZoM1kvNFlZc0xEaUY3M3JoV09uZFVZWGtVUnNRU2Vjcm5qYmkzQTBX?=
 =?utf-8?B?cmhMOWFiTHV0Ylk5dGNMVHAwL2V5WGhRRlBhS1hPcXk0NGtWZkdsakZ0VEti?=
 =?utf-8?B?YjRTblhYWVBFR2dBRFdheHQ4emRrTU54VFk5ZzdqMTcwZnNVaEJJRnhQQzNl?=
 =?utf-8?B?MkRVckFqeU5SQnRvWjlJWlJLK1l3bnJ5WWs3NGRneGFyVk4vbWF2SDN2SXNv?=
 =?utf-8?B?d3Q3NVRnL3hxd05FUFNnV0JkbmV6a25rdWppQTJrVkx5ZWhwU1pzaTZSdHg5?=
 =?utf-8?B?Z2RtYmdONXJmTXlsSWxIQXRieXBBRVB5ZVZHVGhMeE5SRG4xY00ycURiSklW?=
 =?utf-8?B?UUxhY0Zmd0ROam94L0FIYVJxSWx3VitCV25KQzNTSGlURHN5d0I5bDluR1lT?=
 =?utf-8?B?LzZGWFFVRWlFTlhGdGZEQnJPNnBYVUQzRUordzZYWjFqTUdqQUx4NUNSdDVi?=
 =?utf-8?B?b3dtNzJVQ0lNMWJ5MnZ6MHAxd3FZbDNTZ3NMaThPeGgzRlZteU9naHR1b2JE?=
 =?utf-8?B?ZmtHK09JQ3lVa0wyRjJHTEUva0lxd0d4Nm5WbDVxQUxYUmlQeHhCbEN0YlU4?=
 =?utf-8?B?UzhsT0QyVzhmT3JEbXlWdEFCOTNua0QxMFErU21tVEV0OXhTSU5BTXo0emdN?=
 =?utf-8?B?U0ZtSDVkQkhiNVB6R2R5Q1NFSHY2bFIrZjdndGdRUHkwQmV5WWdJcHBjVU52?=
 =?utf-8?B?VFR2aUxzY1pMVEljQ05CRWZrekVkcDJJanlKZXhuY0x1MXh3ZGFkMGxxMGQw?=
 =?utf-8?B?Qi9kbVphMmMzWWxZUjNOaWNXN2RQUmxiTUlEaWVOVmhCdEhVblBDRnNnc1JY?=
 =?utf-8?B?aHhqYmEvYkp0anpkZXV6Q3MvVUtyY3RFQ1dtcEszanRsRHovb0VCYmhINitZ?=
 =?utf-8?B?WHFHalRRTHJxTXhUZE9uZVNSWTdyVmhOU2UrR0hEL2xOYmRGUENFMS9uSVBn?=
 =?utf-8?B?NjJpL1ZoZUhJdEdEL28yeXNLS0ZBZFFSQ0tMVW94Ny9mYUpoTkNGN1kzblhR?=
 =?utf-8?B?azB2cEhoWFRQWXVZK0V0dGNROVNtcDRIYVF4RU1SdnZodVNrQWZrMno3d2lt?=
 =?utf-8?B?RjNZZU90NjBscEJwVTBCY2lhYXdXVThCK0dhcUFia3FJdUNSRHlFcDBvRG15?=
 =?utf-8?B?TDk2SVdtSngrZFFiVTJKMVdLTFUyWFd0b250ZTZrWnoyam5McmtQMmFCL3FT?=
 =?utf-8?B?L2ZJZWp1VGJ3cG5ERVZTREpqZHdjNVhJdy9kc0c1YlBhSC90d0ZVTzIvaE02?=
 =?utf-8?B?dDZvTjA5bk9iaG5oUVp5V09waU1XRDhjYUJHS01DNXR1QXh4UThDeDRLMTBF?=
 =?utf-8?B?aVZ2Q3AzbUk5S2VCQm9QUDRkS0pyQ1Fib1BWY2NsOTBRaVArTDJTbjR2czRS?=
 =?utf-8?B?V1dJY1FpYjlEZi9JK1NSSU5MZ0ZCTkIva0lWemY2UDBwd3M4QitkOHY1VGlD?=
 =?utf-8?B?cGRQRUZldnF5RDl1NGtIL2NCUjIvdlc0dFNwUHhLVkszNlpSbjlUSXlPejdJ?=
 =?utf-8?B?WjhtOTZWTUg5Y2d3bUdHSUYrTnhXYUx2dndSdDB5Qm1kQTJSTnNCT2toUWd3?=
 =?utf-8?B?UUV2NXp6ZlN1Umt6QldyYk5ka1hJREJDN2xBVlpvVGFxSFo3REJxdk91bUhv?=
 =?utf-8?B?VnVGdjluOE44bVE5NDBXQ3F5Um1xV3BaSDh6V3N1R2duWWJnMkM2RWxxQkVq?=
 =?utf-8?B?Nm95K0l0cGxaM0x1NjZXekVMamc1MUFDcWYwQm1nRHJqbjVtTlgxTUZ2KzR6?=
 =?utf-8?B?N2lpb2hpdllVV0tHRldxakt6Zm5COUR4QzAwTHB5L0hXajlETXo3MllxaXlH?=
 =?utf-8?Q?l0KEfT5mBUihr/QrCKtCQ+f+bVu7qn/Uu5xQA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afee8e02-81fc-44c8-40d1-08d956ea5f7f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 01:51:27.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sf9cBWxIgTHAmqVz75NsGqM17GmlP2e8vKA8va+m//ez2eesjCuToqX3QAvAANG7/5A8KzD/998uN0vuV3kbYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040008
X-Proofpoint-GUID: MTzBAF-k-Bt610_N9A5h08eBqLv-nEEk
X-Proofpoint-ORIG-GUID: MTzBAF-k-Bt610_N9A5h08eBqLv-nEEk
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--------------2A026B630E59A2492243E40D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/3/21 5:51 PM, Zhu Yanjun wrote:
> On Wed, Aug 4, 2021 at 7:53 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>> Hi Zhu,
>>
>> Any update on your testing after applying Bob's fixes
> Do you read my problem carefully?
> I mean that before your commit, the whole rxe can work well.
> After your commit, the rxe can not work well.
> Please reproduce this problem in your host and fix it.
>
> Zhu Yanjun

You posted

> In my daily tests, I found that one host 5.12-stable, the other host
> is 5.14.-rc3 + this commit.
> rping can not work. Sometimes crash will occur.
>
> It seems that changing maximum values breaks backward compatibility.
>
> But without this commit, that is, 5.12-stable <-------> 5.14-rc3,
> rping can work well.
>
> Zhu Yanjun
I am not sure how you made rxe to work because it did not work for me 
and neither for Bob. Since then, Bob has posted patches for the issue. I 
also posted that my changes work on 5.13.6 kernel. emails attached.

Even if rxe in 5.14 is working for you some how, please apply Bob's 
patches and then mine and test.

Thanks,

Shoaib


>
>> Shoaib
>>
>> On 7/29/21 5:34 PM, Shoaib Rao wrote:
>>> Thanks Bob.
>>>
>>> Zhu can you please apply those patches and test.
>>>
>>> Shoaib
>>>
>>> On 7/29/21 4:08 PM, Pearson, Robert B wrote:
>>>> I found another rxe bug (for SRQ) and sent three bug fixes in a set
>>>> including the one you mention. They should all be applied.
>>>>
>>>> -----Original Message-----
>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>> Sent: Thursday, July 29, 2021 2:51 PM
>>>> To: Shoaib Rao <rao.shoaib@oracle.com>
>>>> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>; RDMA mailing list
>>>> <linux-rdma@vger.kernel.org>
>>>> Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values
>>>> used via uverbs
>>>>
>>>> On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:
>>>>
>>>>> Can we please accept my initial patch where I bumped up the values of
>>>>> a few parameters. We have extensively tested with those values. I will
>>>>> try to resolve CRC errors and panic and make changes to other
>>>>> tuneables later?
>>>> I think Bob posted something for the icrc issues already
>>>>
>>>> Please try to work in a sane fashion, rxe shouldn't be left broken
>>>> with so many people apparently interested in it??
>>>>
>>>> Jason

--------------2A026B630E59A2492243E40D
Content-Type: message/rfc822;
 name="[PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs.eml"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="[PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used";
 filename*1=" via uverbs.eml"

Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
From: Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
Date: Thu, 29 Jul 2021 12:33:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
MIME-Version: 1.0

I switched the values to the old values and compiled rdma_rxe module. I 
could not get rping to work. First I get CRC errors and then one node 
panics. Both nodes are running 5.14.0-rc1. So the issue you are seeing 
is not caused by my changes, rxe is already broken in 5.14.0-rc1.

Jason,

Can we please accept my initial patch where I bumped up the values of a 
few parameters. We have extensively tested with those values. I will try 
to resolve CRC errors and panic and make changes to other tuneables later?

Regards,

Shoaib

[ 2105.071603] rdma_rxe: bad ICRC from 10.129.135.22
[ 2106.979538] rdma_rxe: bad ICRC from 10.129.135.22
[ 2109.155417] rdma_rxe: bad ICRC from 10.129.135.22
[ 2111.331292] rdma_rxe: bad ICRC from 10.129.135.22
[ 2113.507169] rdma_rxe: bad ICRC from 10.129.135.22
[ 2115.683046] rdma_rxe: bad ICRC from 10.129.135.22
[ 2117.858927] rdma_rxe: bad ICRC from 10.129.135.22
[ 2120.034798] rdma_rxe: bad ICRC from 10.129.135.22
[ 2122.210691] BUG: unable to handle page fault for address: 
ffffbd8562275180
[ 2122.292744] #PF: supervisor write access in kernel mode
[ 2122.355063] #PF: error_code(0x0002) - not-present page
[ 2122.416342] PGD 100000067 P4D 100000067 PUD 1001c7067 PMD 142a84067 PTE 0
[ 2122.497361] Oops: 0002 [#1] SMP PTI
[ 2122.538913] CPU: 8 PID: 0 Comm: swapper/8 Not tainted 
5.14.0-rc1_rxe_values+ #4
[ 2122.626155] Hardware name: Oracle Corporation SUN FIRE X4170 M2 
SERVER        /ASSY,MOTHERBOARD,X4170, BIOS 08140115 07/04/2018
[ 2122.763248] RIP: 0010:rxe_cq_post+0x9e/0x220 [rdma_rxe]
[ 2122.825578] Code: 44 8b 8b 48 01 00 00 4c 8b 47 08 8b 4f 28 49 8d b0 
80 01 00 00 45 85 c9 0f 84 7d 01 00 00 8b 57 34 d3 e2 48 01 f2 49 8b 0c 
24 <48> 89 0a 49 8b 4c 24 08 48 89 4a 08 49 8b 4c 24 10 48 89 4a 10 49
[ 2123.049907] RSP: 0018:ffffbd85464f0800 EFLAGS: 00010082
[ 2123.112225] RAX: 0000000000000246 RBX: ffff9dad4fd3f800 RCX: 
0000000000000000
[ 2123.197389] RDX: ffffbd8562275180 RSI: ffffbd8546273180 RDI: 
ffff9da2c3cee840
[ 2123.282555] RBP: ffffbd85464f0840 R08: ffffbd8546273000 R09: 
0000000000000001
[ 2123.367722] R10: 0000000000000001 R11: 0000000000000001 R12: 
ffffbd85464f08b8
[ 2123.452886] R13: 0000000000000000 R14: ffff9dad4fd3f940 R15: 
ffff9da3002ac008
[ 2123.538053] FS:  0000000000000000(0000) GS:ffff9db94fa80000(0000) 
knlGS:0000000000000000
[ 2123.634642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2123.703190] CR2: ffffbd8562275180 CR3: 00000013f340a005 CR4: 
00000000000206e0
[ 2123.788357] Call Trace:
[ 2123.817443]  <IRQ>
[ 2123.841335]  rxe_responder+0x5d9/0x2490 [rdma_rxe]
[ 2123.898467]  ? native_apic_mem_write+0x10/0x10
[ 2123.951445]  ? native_apic_wait_icr_idle+0x22/0x30
[ 2124.008575]  ? arch_irq_work_raise+0x3a/0x40
[ 2124.059476]  ? __irq_work_queue_local+0x48/0x60
[ 2124.113486]  ? fib_table_lookup+0x21e/0x640
[ 2124.163348]  ? wake_up_klogd.part.31+0x34/0x40
[ 2124.216319]  rxe_do_task+0x94/0x110 [rdma_rxe]
[ 2124.269297]  rxe_run_task+0x2a/0x40 [rdma_rxe]
[ 2124.322275]  rxe_resp_queue_pkt+0x44/0x50 [rdma_rxe]
[ 2124.381485]  rxe_rcv+0x2eb/0x900 [rdma_rxe]
[ 2124.431347]  rxe_udp_encap_recv+0x6d/0xd0 [rdma_rxe]
[ 2124.490555]  ? rxe_enable_task+0x10/0x10 [rdma_rxe]
[ 2124.548725]  udp_queue_rcv_one_skb+0x1f2/0x500
[ 2124.601697]  udp_queue_rcv_skb+0x50/0x210
[ 2124.649475]  udp_unicast_rcv_skb.isra.67+0x78/0x90
[ 2124.706600]  __udp4_lib_rcv+0x57c/0xbe0
[ 2124.752303]  udp_rcv+0x1a/0x20

On 7/29/21 12:57 AM, Zhu Yanjun wrote:
> On Thu, Jul 29, 2021 at 2:52 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>
>> On 7/28/21 11:42 PM, Zhu Yanjun wrote:
>>> On Wed, Jul 28, 2021 at 1:42 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>> On Tue, Jul 27, 2021 at 09:15:45AM -0700, Shoaib Rao wrote:
>>>>> Hi Jason et al,
>>>>>
>>>>> Can I please get an up or down comment on my patch?
>>>> Bob and Zhu should check it
>>> In my daily tests, I found that one host 5.12-stable, the other host
>>> is 5.14.-rc3 + this commit.
>>> rping can not work. Sometimes crash will occur.
>> Can you paste the stack?
> [  381.068203] rdma_rxe: qp#17 moved to error state
> [  421.464485] BUG: unable to handle page fault for address: ffff9e5de298d180
> [  421.464515] #PF: supervisor write access in kernel mode
> [  421.464532] #PF: error_code(0x0002) - not-present page
> [  421.464549] PGD 100c00067 P4D 100c00067 PUD 100dc1067 PMD 125e78067 PTE 0
> [  421.464572] Oops: 0002 [#1] SMP PTI
> [  421.464585] CPU: 25 PID: 0 Comm: swapper/25 Kdump: loaded Tainted:
> G S      W  OE     5.13.1-rxe+ #17
> [  421.464613] Hardware name: Intel Corporation S2600WFT/S2600WFT,
> BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [  421.464642] RIP: 0010:rxe_cq_post+0x98/0x210 [rdma_rxe]
> [  421.464667] Code: 8b b3 48 01 00 00 4d 8b 48 08 41 8b 48 28 49 8d
> b9 80 01 00 00 85 f6 0f 84 78 01 00 00 41 8b 50 34 d3 e2 48 01 fa 48
> 8b 4d 00 <48> 89 0a 48 8b 4d 08 48 89 4a 08 48 8b 4d 10 48 89 4a 10 48
> 8b 4d
> [  421.464718] RSP: 0018:ffff9e5dc6ce0918 EFLAGS: 00010082
> [  421.464735] RAX: 0000000000000246 RBX: ffff8b200cabd800 RCX: 0000000000000000
> [  421.464756] RDX: ffff9e5de298d180 RSI: 0000000000000001 RDI: ffff9e5dc698b180
> [  421.464777] RBP: ffff9e5dc6ce09c0 R08: ffff8b2014d85a80 R09: ffff9e5dc698b000
> [  421.464797] R10: ffffffff8bc90940 R11: 0000000000000001 R12: 0000000000000000
> [  421.464817] R13: ffff8b200cabd940 R14: ffff8b206e014008 R15: 000000000000001a
> [  421.464838] FS:  0000000000000000(0000) GS:ffff8b1fd1040000(0000)
> knlGS:0000000000000000
> [  421.464861] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  421.464879] CR2: ffff9e5de298d180 CR3: 0000000c4df4e006 CR4: 00000000007706e0
> [  421.464899] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  421.464920] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  421.464941] PKRU: 55555554
> [  421.464950] Call Trace:
> [  421.464961]  <IRQ>
> [  421.464971]  rxe_responder+0x621/0x2480 [rdma_rxe]
> [  421.464993]  ? __fib_validate_source+0x2e9/0x450
> [  421.465013]  rxe_do_task+0x89/0x100 [rdma_rxe]
> [  421.465033]  rxe_rcv+0x2eb/0x900 [rdma_rxe]
> [  421.465050]  ? __udp4_lib_lookup+0x2c8/0x440
> [  421.465065]  rxe_udp_encap_recv+0x68/0xc0 [rdma_rxe]
> [  421.465085]  ? rxe_enable_task+0x10/0x10 [rdma_rxe]
> [  421.465104]  udp_queue_rcv_one_skb+0x1df/0x4e0
> [  421.465120]  udp_unicast_rcv_skb.isra.67+0x74/0x90
> [  421.465135]  __udp4_lib_rcv+0x555/0xb90
> [  421.465150]  ? nf_ct_deliver_cached_events+0xc1/0x120 [nf_conntrack]
> [  421.465181]  ip_protocol_deliver_rcu+0xe8/0x1b0
> [  421.465199]  ip_local_deliver_finish+0x44/0x50
> [  421.465215]  ip_local_deliver+0xf1/0x100
> [  421.465229]  ? coalesce_fill_reply+0x2c1/0x480
> [  421.465249]  ? ip_protocol_deliver_rcu+0x1b0/0x1b0
> [  421.465265]  ip_sublist_rcv_finish+0x75/0x80
> [  421.465281]  ip_sublist_rcv+0x196/0x220
> [  421.465296]  ? ip_local_deliver+0x100/0x100
> [  421.465312]  ip_list_rcv+0x137/0x160
> [  421.465325]  __netif_receive_skb_list_core+0x29b/0x2c0
> [  421.465344]  netif_receive_skb_list_internal+0x1c3/0x2f0
> [  421.465361]  gro_normal_list.part.158+0x19/0x40
> [  421.465376]  napi_complete_done+0x67/0x160
> [  421.465391]  i40e_napi_poll+0x53b/0x840 [i40e]
> [  421.465426]  __napi_poll+0x2b/0x120
> [  421.466123]  net_rx_action+0x236/0x300
> [  421.466783]  __do_softirq+0xc9/0x285
> [  421.467440]  irq_exit_rcu+0xba/0xd0
> [  421.468091]  common_interrupt+0x7f/0xa0
> [  421.468737]  </IRQ>
> [  421.469366]  asm_common_interrupt+0x1e/0x40
> [  421.469990] RIP: 0010:cpuidle_enter_state+0xd6/0x350
> [  421.470608] Code: 49 89 c4 0f 1f 44 00 00 31 ff e8 45 49 99 ff 45
> 84 ff 74 12 9c 58 f6 c4 02 0f 85 32 02 00 00 31 ff e8 ae c8 9f ff fb
> 45 85 f6 <0f> 88 e0 00 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d 04
> 82 49
> [  421.471935] RSP: 0018:ffff9e5dc679fe80 EFLAGS: 00000202
> [  421.472599] RAX: ffff8b1fd106bc40 RBX: 0000000000000002 RCX: 000000000000001f
> [  421.473266] RDX: 00000062213d764d RSI: 000000003351fed6 RDI: 0000000000000000
> [  421.473920] RBP: ffffbe51c1040000 R08: 0000000000000002 R09: 000000000002b480
> [  421.474558] R10: 0000a82bea904be8 R11: ffff8b1fd106a984 R12: 00000062213d764d
> [  421.475172] R13: ffffffff8c6c6d80 R14: 0000000000000002 R15: 0000000000000000
> [  421.475763]  cpuidle_enter+0x29/0x40
> [  421.476348]  do_idle+0x257/0x2a0
> [  421.476926]  cpu_startup_entry+0x19/0x20
> [  421.477497]  start_secondary+0x116/0x150
> [  421.478067]  secondary_startup_64_no_verify+0xc2/0xcb
> [  421.478640] Modules linked in: rdma_rxe(OE) ip6_udp_tunnel
> udp_tunnel xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
> nf_reject_ipv4 nft_compat nft_counter nft_chain_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun
> bridge stp llc nls_utf8 isofs cdrom loop rfkill ib_isert
> iscsi_target_mod ib_srpt ext4 target_core_mod ib_srp
> scsi_transport_srp mbcache jbd2 rpcrdma sunrpc intel_rapl_msr
> intel_rapl_common rdma_ucm isst_if_common ib_iser ib_umad rdma_cm
> ib_ipoib iw_cm skx_edac libiscsi ib_cm nfit libnvdimm
> scsi_transport_iscsi x86_pkg_temp_thermal intel_powerclamp mlx5_ib
> coretemp crct10dif_pclmul crc32_pclmul iTCO_wdt iTCO_vendor_support
> ib_uverbs ghash_clmulni_intel rapl ipmi_ssif intel_cstate ib_core
> mei_me acpi_ipmi i2c_i801 joydev intel_uncore pcspkr mei i2c_smbus
> lpc_ich ioatdma ipmi_si intel_pch_thermal dca ipmi_devintf
> ipmi_msghandler acpi_pad acpi_power_meter ip_tables xfs libcrc32c
> sd_mod t10_pi sg mlx5_core ast i2c_algo_bit drm_vram_helper
> [  421.478702]  drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops drm_ttm_helper ttm mlxfw ahci libahci pci_hyperv_intf ice
> drm i40e tls crc32c_intel libata psample wmi dm_mirror dm_region_hash
> dm_log dm_mod fuse [last unloaded: ip6_udp_tunnel]
> [  421.483665] CR2: ffff9e5de298d180
>
>
>>> It seems that changing maximum values breaks backward compatibility.
>>>
>>> But without this commit, that is, 5.12-stable <-------> 5.14-rc3,
>>> rping can work well.
>> That is strange because all the large values do is initialize the pool
>> with large values. Nothing else. So unless large values are used there
>> should be no issues. Is it possible that the issue is with 5.14-rc3. Do
>> things work between 5.12-stable systems. Anyways, please post the stack
>> trace and also information on the setup and rping commands used.
>>
>> Shoaib
>>
>>> Zhu Yanjun
>>>> Jason

--------------2A026B630E59A2492243E40D
Content-Type: message/rfc822;
 name="[PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs.eml"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="[PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used";
 filename*1=" via uverbs.eml"

Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
From: Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <6e99e37d-2476-21ab-0584-6f4b12982b9d@oracle.com>
Date: Thu, 29 Jul 2021 13:33:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210729195034.GF543798@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
MIME-Version: 1.0


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

--------------2A026B630E59A2492243E40D--
