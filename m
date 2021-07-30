Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595313DB050
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 02:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhG3AeT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 20:34:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1638 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhG3AeS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 20:34:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U0G1Nx029378;
        Fri, 30 Jul 2021 00:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aJ04dl1yNLOhH7AKDqZzfXcZ/1e7XRtS0GLoFKkL74A=;
 b=k6SlhrcursmZVrtTbwQ6nQ86S2UqyeGTThYoSQZ6qxyIYZhpx6rm7yUtiJg0SOxd834Q
 5cBjmIn9twEWADRcYRVHbA89zNHB68animOIKfXPBEIY3iFRXYkzUGK6DXcbF7tU60hx
 dyTh+6eY5aFUe5TBMHA6BP3EzQUNGRuXXI7c2/HsffrLcjKdVN+ZH/6B0XnH6ESWWWfN
 ubw5RkpDlrknJ9d6mONi098/+eS6o5X9PobkTiWbCvRweXm3psYtnHjYDdFJhieAgwqw
 res2ga+uUa0uIB9BqzwncdplJNdY+YOhO60vvH7AkzLoKyn7224LPbQJ3YTRgtTLjXiT 2g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aJ04dl1yNLOhH7AKDqZzfXcZ/1e7XRtS0GLoFKkL74A=;
 b=dfwb7aSCASYcMuRrcFV1/VCnWMtiUZsNBfyYieJCs4BGnFH+//uMl4rhXU8rFKjrRTu4
 5H+gaW0jtkfO70/QjTG6XhL+T9cqHBLCTigp8Lwqubp5u99ryXR+MeP08dHEtwc7Elto
 1YhY9cWKFfdHNv7RYvEoS7cITsXn3OBJ+F/thIddhW4U5ltrB75Z2A11SNBKoj69cxHO
 xe9Czv2sbOotM8nZ3Dd26AnWxQbNuW5VFwaQCgdKvsDaVeZgEws2JmoJrY438ohF0kSG
 TgFdLyZAlQMylq2ofzI4gtE2UDJ0erkEMnWMHsXa+vZrwRcd5nXsXP+NkuEgMGERW9kv pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2jkferh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 00:34:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16U0LdsY037266;
        Fri, 30 Jul 2021 00:34:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3020.oracle.com with ESMTP id 3a234d9dhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 00:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3qEGrGeuulsGp5OHlHpmwPOPjlZECx22KNTQzW4wHqjhOL8yG2E2zmQEApEryeHk5AZu7K5zziez1nDxLikf83QkUEH4S2aw4ZZUs2Wv/ytE9gk1TWqYNVH23sH4lRARgO5UsRYSP0jmuz6A2eHQRbVvPw48byYjxvednDJvm6V2jFHINco6BfwatXyT3iz4c4YTr2rX3i34612I3Y46gdopimnF3USF+poVyAy+5Sm0hEdAlyBz8VPCJobmRLzfx4uHqpy+wf3/PFicwVKD2jDhfvGXwL/zXjY1myENy7qBIqiziLvgKcGT6+2nLW1NtKbF8ELjHkliJm6dMgx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ04dl1yNLOhH7AKDqZzfXcZ/1e7XRtS0GLoFKkL74A=;
 b=DVGXKE0lPdaPt+NFxbAsYs6PdkRyTeC2lTSZOjkDKgxx/wO2u82pa9iGmETmAFQk2gBvP5xKI2+RzB3yt8X6jiM2gMYE1WOLwiWzPZ5EkFzVFzVYhCV/gIBUhgcQBhiUxElZv/Q3FsOOnkHhXJZ+hnR2z6OjxGS+NBJDDjURdQYxnbpWZXLFkEzQtJkxanj2nbHo7YkK523gTNHirBr302bo24AjOztDNvpfKYjYXoqo1nkhM25+wTtPP7Z146gkHqMz/nfp49cyFxjCcPjvXI0vfqDEEDuH3N2zc8BDb3tD7OqXTJve42jPYroE9HXCu04s/50mEM+N7fOlG528+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ04dl1yNLOhH7AKDqZzfXcZ/1e7XRtS0GLoFKkL74A=;
 b=llC3QJW8wJgI/jLo97arMkrMMAYRi+sF+zSk4Fvq7Wf1E/4YbC2pqdcjLglFEE0vN/y71YJj5eTQQfDNcFY4ah8xQuba21O1c+C2MsPYWUGLeAtWYZmsKvE3MD6dmkqyzrkyYfJjKkegCdGDe6weGeKYHR5vYQgWhU278Gg3TW8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 00:34:09 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 00:34:03 +0000
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
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
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <14b9f35a-0086-834a-c05f-361a26befc13@oracle.com>
Date:   Thu, 29 Jul 2021 17:34:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:806:23::32) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::783] (2606:b400:8301:1010::16aa) by SA9PR13CA0087.namprd13.prod.outlook.com (2603:10b6:806:23::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.9 via Frontend Transport; Fri, 30 Jul 2021 00:34:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d92e1e42-6895-4ef9-f3c1-08d952f1bb39
X-MS-TrafficTypeDiagnostic: BY5PR10MB4130:
X-Microsoft-Antispam-PRVS: <BY5PR10MB413064F205BB8891C39EFF14EFEC9@BY5PR10MB4130.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rttYTXyBDF/Cn7GOV56FkvBDJfiiCHTVY5NrKOLfXTcj+lKysO5G1PkqCgWutcP20gfNqHT+I26SK2VDYQSnsI7Y+EfIwA/4TmuZVRg7kCbPdVj9KkUygA9eMMHSRjYyQxzJpDs3JZVMTOXo2HCrgKqn/GY0uY+gdjxaU5G/aTgGT8xgKU/naw8sZEXs6RzfkV3RHDTDU8vaF78gO4UYD9zU+m3kOYfZkdrb3CU80SHQjLtbDaMehfQDtUxpvpkC/Hlm3xHEneWEjPPzWXiPMFUaY/v+q9Eqe6byEspVI2TfanZGI7OAxTWuAqDNlk9uW4HRdrSMu7pN4UrSLXVW9Td5ZoLi5946EFzMITwdY57Lk/83FxQneq1CPbNlJu0I5JoRZmd11Da8PrexLN1USJMZV24STsq+w5HevcYEZakjDJoyoDIdmRVAlPiJHJii7GpfMeEBfoOH+k/oYARQngXJIiATlP493jbnvMGCkkxGv0P+GOahIbT+7VV39eSXCGUVVqp318nNGtu8VD9YEhHla/W99wcvoE3ISuZ3/JnXLCs3Ehi34S3B/ezWs2IW0l3eQ8KcwsOVyxDlCstjTpHWHnybFSd8LywHzN5t+HAF2wwwS4S0wZAJmjBkBTjdUVgHni6SF5j37Cv+Bcvo3De99C0Pn3P6e3PlE0Ns36CegsMB1wwZSi3J6hnpfrGj2i9+yvhlrTJ7yJ6HkQI+8ys7CuK3cCnOCUDYvg8wcXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(31696002)(4326008)(53546011)(36756003)(66476007)(38100700002)(478600001)(2616005)(83380400001)(110136005)(66556008)(31686004)(66946007)(8936002)(8676002)(186003)(86362001)(316002)(6486002)(5660300002)(54906003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZnQnNYTTJsSUV1TXJidVBFYk9xSWdkTkFQWk1jQVk3UWM3R3dIZXcxVy9E?=
 =?utf-8?B?a2VHRTVSdm9wUEl0QmhMbmVmVkVKWDJhQnRXRXgwakM5N1JsRzVWQTJzZnlK?=
 =?utf-8?B?VEhQOUFOZ0NwUysxK0R3Vmg5NHIwU1FBbHJsMEtjaDR0K1R6NEpSb0kxZHc0?=
 =?utf-8?B?M0htVmFsR3hDTFZhWkJEdnIyZzhpOVdXTGJaV200M3B1ci90eDNISVRQaG1U?=
 =?utf-8?B?cjRhUGVMc3ByajhhVlpMaDhrN3JDTXVNZUFJZ1IzQnp3QXdJbWZ5MDRxQWx6?=
 =?utf-8?B?aEVwUi9YSGl5RDFXRFFkUXluOGFuRkhEaTFSOGdSa0VoaHBFQjM1ckdLWGx0?=
 =?utf-8?B?Y1NvRGRFTlFBR1RLMXJ0alJEY05ISnhwNFRWNDFhc1hzM0pKaDZTWUNJank2?=
 =?utf-8?B?Q1owdXNORVloeHJWSjRJcWE2blMvMjhtYmxlZ085K2MzQ2dkeDRsZWorWXQv?=
 =?utf-8?B?aE1Eb2VMblRKUGsrRzZtSEJXMkZIdm1DajZ0cVJaUjNzWWoxWmlKNThWTmI5?=
 =?utf-8?B?K0Q5K1V5cStXLzlkUGEzbVZzUEZIc0FmZ3h6YXF4TUhEUFN1VFJ2Y1p2elNW?=
 =?utf-8?B?ZGMyS0hYUVhnUTNwcHl3NkxUbEJVQThxdjlDOGpvTlpjOUlwbkNUaVdGUHFq?=
 =?utf-8?B?UlJJclBTTXM0S0dvOTB1V1JNUEUrMFd5VW1VSjliU2NQdVJ4b282eCtvQ2h1?=
 =?utf-8?B?enhaMHFNQVNkTWNDQkQzaXpHNEJTNkYzSHNsMkJDbUx4S3BYZVdzQWV1S3lT?=
 =?utf-8?B?Vkx0UmJaaFNKUVhWU2JmVjhmUWQ4bUFxNUIrRFc2NUFlWDRGd2RVNXZYZ24v?=
 =?utf-8?B?bmRnMDlXZm1iRXRWK094VithUUgvV0lrN1BnZmRmemNocVd6eEJkaG5GeDFX?=
 =?utf-8?B?Q0tNZ0hpSTRvUTZUcWMxeFVIcFZUc1BBNEFFSk1vK2IxalpZeFNOOUtqdnp3?=
 =?utf-8?B?aVM1YjViK2RTRzMzYnJ3QXVodThta25wM0wvRXFXdFZFNmJQdTR2RkNBcWV5?=
 =?utf-8?B?Um9oQjJyOWZ1T3d0T0d1bmFKNGdGREJ4K1J2Y0dGLzNsaUtiak85Uk85dlk5?=
 =?utf-8?B?cUhSZk5ubDFSUVAwVmVNRDVNWk16aitKNjhYSEwxbVA3emxOSFcrV1o2QjhB?=
 =?utf-8?B?NUFMS05KQXIxTVNXdWc1YWNEeTVzUmVqUXU2V3lncXVheXVYL0ovWUNWcTdS?=
 =?utf-8?B?OFVNTmtJSGh0UGhCa2xkVkxWalRzcHlKWnpwZEo0QVgwcDJ4YXU3ODRxWng2?=
 =?utf-8?B?aDF4NWlmVE1qWFFGY2lKT0srZkV4U2ZlZEdKdVRKbGpLVTJDdDFqQmY1LytI?=
 =?utf-8?B?MGYwNjMyemFPTjhmVFRpMTFEa0FGVEFpVWVsS21wYUZidStmSDNYUi9qUHls?=
 =?utf-8?B?aEhXbVl3bW1yT05ScmVxMHhYajVxVWpNMWE4ck8zc2phR040bGFBeUpGWjVm?=
 =?utf-8?B?b01yS2E3VTlPZjFmbW45OVF5OW9NaEZYS2xkSGpheWxta3g3bXNEREtPSEZq?=
 =?utf-8?B?WW10TytMYlkwV2ZxV1l3dHhWQ29WVDhLQ201SjhtbGx5UWVYQ083Mi9vRmNM?=
 =?utf-8?B?NWQwTzBJdTVZYXEyYjFiTTlZRFMwTk1vZ2JmN1FIYmI2OUZ3V3dqdXNBZnlN?=
 =?utf-8?B?WURhcXptc0dpWEgyUGRyMFh1MWZDMUIrYVRHWk94NjRtVW1ORE1ocTErVFVw?=
 =?utf-8?B?SVpPd0JVT1pETVU1YkVycHNibDQzT21PcGpFcHExdlg4RTZvTG9DUlJTSDkx?=
 =?utf-8?B?NXBGVWRDdWFpanBYdmd3MGxFaXpTSFNCTGpOdFBDS2xCTnlmZ21DQ3V3Q0xT?=
 =?utf-8?B?T3VZeERIUDNzRXZTZ2xSZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92e1e42-6895-4ef9-f3c1-08d952f1bb39
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 00:34:03.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYANdWxevVQU2qDqzeguRaJ4gFjmx5xxOmrADsMDVOVjY7qL5YhtVvghRumhJN0DC/1W55g83N6xduXKc0TUkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10060 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300000
X-Proofpoint-GUID: b-0SQ3iGqnv6SeyknZnk4wMVSlGEQcH8
X-Proofpoint-ORIG-GUID: b-0SQ3iGqnv6SeyknZnk4wMVSlGEQcH8
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Bob.

Zhu can you please apply those patches and test.

Shoaib

On 7/29/21 4:08 PM, Pearson, Robert B wrote:
> I found another rxe bug (for SRQ) and sent three bug fixes in a set including the one you mention. They should all be applied.
>
> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, July 29, 2021 2:51 PM
> To: Shoaib Rao <rao.shoaib@oracle.com>
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via uverbs
>
> On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:
>
>> Can we please accept my initial patch where I bumped up the values of
>> a few parameters. We have extensively tested with those values. I will
>> try to resolve CRC errors and panic and make changes to other tuneables later?
> I think Bob posted something for the icrc issues already
>
> Please try to work in a sane fashion, rxe shouldn't be left broken with so many people apparently interested in it??
>
> Jason
