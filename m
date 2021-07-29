Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498F33DABDE
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 21:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhG2Tda (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 15:33:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14498 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229713AbhG2Td3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 15:33:29 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TJVDJ0031986;
        Thu, 29 Jul 2021 19:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pQlrABsDAFvnYcJYaNkSZc+XBL44wx1fPphxUC3DEXk=;
 b=wQKY2UYPwY9CI2wgpbuckTek9DgaI/j3nRahgop2FznOnmW8VBnjuqyWtCQeUiriDSKf
 HYICRivdxmBtLlRRE3VgTvcA5fjffLye6LdxxG1CpqLP0sG8dQ9eqEFbp01XRFCL9KMJ
 hBMRVAyN7bowwW+OUcoRisFHXnVdU2L9AzKRqAR97YsUlg4FC8o+9hSJBezNyY2WKPHc
 7mI5H8nrQvTpV3LfoCedpg1u7e6LTOT/lMkLU1IgcgY6DfUYe4Lwlvjksbwws4zB7pGN
 aTP0Kph4TOnWdCSCvzGhGOvj+a4aPKrKhHJIqps0YeTIzQ1wCQKSZ79ebrNFEckbd+uk pQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pQlrABsDAFvnYcJYaNkSZc+XBL44wx1fPphxUC3DEXk=;
 b=WLR7xYn+mGGqnQmnnOiVh+kwDvkNBCrwDooPTDrSMzArrtWBj5PSwsRQfVu+uJNFeyX1
 dh7o0qAeBEczCy0TAYRHWoPD0Jem6yYACTGH5EFDFLkV6AEXzYKBqEHZF6C4mXFy17di
 CFOh1RSDjyCh1tYrYyl16omUE0QEetbpCkflFJmEf8r+HyszWZoTvZDRduTJHQW9Cu/6
 1UGd0WlzrPJDf63KUH3S3Eev+ayL7ARdDU/yrz3JLDgc3/DRnDeslo8F1DFHdcHxHMj+
 siUyvVUBExz6SeIc8BBc4yRmfvccU3sKa1Ivnua3TUHzlB1wkGe2p3lgnlGi61F44F15 Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a3cdptsk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 19:33:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16TJVaUs149785;
        Thu, 29 Jul 2021 19:33:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by userp3020.oracle.com with ESMTP id 3a2351hs46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 19:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSTNN1ozeMukUP0+j+kIERA2+ZUVv5+IiZTOLkKhQOb40R+ghp/d7T6K8qRLK4OK7qCy462b0N0Z4PPSYtLvwrsBZZdbGKYjerdLhc7vTMFq553UENx7ltQbvnP3tlcRR3W56046u/zrOiyoAsESP7lOP60aHVavqfmvjWs18leMSuL6BGN9sypvF97410rO9m+15REjVGVZ4W5fbHp+Jz4I8ykiQsPT5/GtnMXnWY8yRqtt0y7xKMoaBySpN5DjLvXeUeaC3i8X21076l2T3rNc1emqxM2bjqq+lAzHXiVr8yPTwk7bi+p8mDGx6VD0iuvBusowHvOS0I3klxuqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQlrABsDAFvnYcJYaNkSZc+XBL44wx1fPphxUC3DEXk=;
 b=eqD9SS9xQJcGs7G7E1ATHe0U7+PQ2FUgoO8KBuqdvkcNBmNuzkyB3OR4k/N3gYfZ9bBdlZCgjwN7WsHOK4VQUfshG/QXuuGN0x9dVmN/acknaRI4kyHaFQtNmbW2qkzp1H/iEx5S01VE5yqpghWg5/Jp/vDZ/77n9ErMvNc8p3T3hP+9D8/542HWzS1GQlnkmksTVK1knq1ZhRktxUVwgyJLMZGux7lbt3nriqKp/NkisfZfjMZoafefh6LwDk04ZjdioVjApamuTNDU79ZS8RA5UVuDWIHWEMQ+CE0hQ5Z4n9RiYcOavFjJOU3ZAjLtMazIssiszxNlci1iHSSLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQlrABsDAFvnYcJYaNkSZc+XBL44wx1fPphxUC3DEXk=;
 b=cdJ6rgG+xf2FVrlq5r9qPVIUOcmEq6k+9KNj/LJBcB/OX4dIye8MWKYD2XW+lUhIq7qtlue/WEpFn1gu8Q/RZUawsxh7IMB5fqryOSfNAw6U2IShvPh4euKLXz6jc8DHKEkNaiqGk2o5jtoTr5zXFMCfKmqStFNKIAPMWjVdhMU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB3191.namprd10.prod.outlook.com (2603:10b6:a03:14f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Thu, 29 Jul
 2021 19:33:18 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 19:33:18 +0000
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
Date:   Thu, 29 Jul 2021 12:33:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:806:22::14) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::4a6] (2606:b400:8301:1010::16aa) by SA9PR13CA0039.namprd13.prod.outlook.com (2603:10b6:806:22::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.9 via Frontend Transport; Thu, 29 Jul 2021 19:33:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eac38efa-f80e-4f3c-53e8-08d952c7b768
X-MS-TrafficTypeDiagnostic: BYAPR10MB3191:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3191BA24E42503195A05B93AEFEB9@BYAPR10MB3191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAwLGgFzSWMLq3LxzSDsiT2sW67DkNfJdagbasPPJyNwQBbzDr2r32K1C53MtBQ2wU4xDVjybwVPOXcUGICkI2MZ2av/KI9tDRRR6jnE9WZ1aIS5N0RIO4/xX6sEN30zj/B1Ic+pm/cUTGXKJ0PjryVwtcQVR1elzu4Ecpf+oOZaXKCm8OTWYIwPE2djat7sHxkJWgbRKMl15KOV4szPIznmqBbJv768DryfChtN1yyUq7RjTQvSKuRTo7paOjfxa/Y0b0W/caPj0GhMLhx9Pln9UhojmT0d6f9WNphz8Jm4FaKBC9sE8vkp/8Srohdu08pY9yEbLjL4fgfW2fXqUhrVlGoirvzM9fWeHgcWUd9Gv8PHwWGvTCfCctmIoYgypw9RlRF43zxKTVVQT+85GkzPnox8L5MIPHtrBMlwaSj5HhSfEWh3jR2smC8f2oj9iVpFSJnQI8ZE9lMTSa+XOU6YsNv1INsbdgPwVVh9rZGuRreplTI00YgdqNQpyQGV43T9WT9Q9kE9I1STMam3Fh2newEMqpr553Jb3sO4Q0zG1CGgul58o/U8ECaT1sSjzhKL+JrlGajBEBuaRZNd24+VacTz327l6bEenHZQ0jIK4hqJ9oVXBSDw7G0oT3/ed0Zcmv4e8LV2eAP0vUep0KKaivox+msP+qyXStdmYXqes664wivbD5236mdc6N6DcRmOKZK6cwPppa0vtyq4KXp5+J6vvaCgNaNp3byF1Os=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(346002)(396003)(45080400002)(66476007)(38100700002)(2906002)(2616005)(31686004)(186003)(86362001)(4326008)(54906003)(6666004)(8936002)(66946007)(66556008)(53546011)(8676002)(5660300002)(478600001)(30864003)(36756003)(31696002)(6916009)(83380400001)(6486002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmUzbEs2cGFZVjFjL2p1MzFUT3pJbkVXRThkQUFrSWhVRnhZNWF5Z1N6ckxz?=
 =?utf-8?B?VG1qQ3Rpamd5VkIwKzIrYjJlQ1FnUGpmZzk3RDRweFg2VHJaaFBvMWM1U3I1?=
 =?utf-8?B?NjZNU3htZGN2TmJFS0x5eHlWMGlxc3lCUXNHMjFvSHdwaExwME5vei9qek0y?=
 =?utf-8?B?elBTVnRKWXhqSnN6cTVWK052WGh0R3p4ZkxseklmaDlZRmNCMDh3M1YrdlZO?=
 =?utf-8?B?aGhOUVN6ZVY3TGU3aHIyM3RoUi9Pb0QydW53N29DRklDN2hFQjVHYWFINmlh?=
 =?utf-8?B?OVJhL21qVlZxYUhtYm56TjlBTjBtMFRoSnpybmgydE9vME1DWEZtOFlQZFJC?=
 =?utf-8?B?TU00YVZ3VCttNlM5bCsxRkZwZWZlS1VMZzFsUmF6KzVHSUc5M0hvNWUzN3E1?=
 =?utf-8?B?VEtLRy91Q1JFQjE4WFIyVHJnVldGaHNRcUk5UGpWUk1pdlVFdXA2c2l0VlZ0?=
 =?utf-8?B?YUMwdDhSWUhVQTlPdHZLRVdLbm00UHRFUGE1b3IxZ2wwQlVLTXA5aExlTk5h?=
 =?utf-8?B?OEMwT09UajBOV2FWQi9HM3d6S1Nnd1k5ck5oR2JicElQTjBqaVVHZ1FHbW00?=
 =?utf-8?B?Nk1DaU55ZStRRTFrRFZzcUZnMmt4YWVRZVFTMVFxTmYvd3BQNVZLYjVGOXpE?=
 =?utf-8?B?SmJlWGhQNi9iUU9JNzkvK0Q5cVJwWDBkb2JtZGxGYWVydWhJSUtROUx5M3lz?=
 =?utf-8?B?NEJLc3BiWGtpMWNqZmF0eHRrUy9YWnJCRW1WQ011d3BVQ0o2Z0QyNzc3QjJj?=
 =?utf-8?B?dFFKUnhaNG1rSWVYczBEM0FYVWs4NzhUbzNlZTFjZVZXQTNldCtPVXl4VDBF?=
 =?utf-8?B?S3IrMVcvZnNUUWhaVkNFWmp5WmpsY3g0RGx1S05KQkJKWWo2N1Y4ZEhsT1Zo?=
 =?utf-8?B?OTZ2THErTkVmaHJHM2dIRTVDZWdWM0hSTnlqRk1iREx3RUxCU2pYaXg3aDQx?=
 =?utf-8?B?YmxsSStoczBXbTc3WDQzZmM0cHRrSmMyMkpJUkxEdytLUjdZVW9QQVpxQzZm?=
 =?utf-8?B?UXIvakQ5Mmd2akFyWWpYTWNtTzBOeUZZb0JKQnIwVkMyNkl2a1BmWVdjVlBF?=
 =?utf-8?B?dVpRU2w2RWNtanBvS0hJNTFGRm1kWUc1ZFNHcXNGUUhRVktvaXFWdTV0R0ZI?=
 =?utf-8?B?V2Q3UTNQaGpHNDJSZzU0Vk05NmdPL0lYek4wa0lMZkU2dTJ2dzFxTUptdURt?=
 =?utf-8?B?UVJlZy9hSW5nZHN0VFZvZ3F1a0gya2p1MGg5VHVFR3N0Qi8vWDh4K2RhTkhK?=
 =?utf-8?B?N1VldWVEU2YwdFVSNWR4WTRlNGRqb3hzejJmTllEOW9Rd1J0SE5NZFYwZHph?=
 =?utf-8?B?eHRWbWxPWC9lSmI0K0REckhJNk9oaU5qcDlGQ3Q0VGJwVTdEZk91cVdoMHk0?=
 =?utf-8?B?OUhzYzBiRTFLcjgxU2hVV0FnWjBJVVg2RU1UZWx2ajR1MFZoYi9SZloyVHBT?=
 =?utf-8?B?RVNaMW1UMG5nUVJadUJyeWdCSUZHVnU5KzRtSGdBT0lZZHlHU2tnLzhCTm5B?=
 =?utf-8?B?Z3RjcS91T0Y5UlhXQ1VuektBQjM1eVB1VTFRUkNuZnRhYXZhT3JrRUVSWDFl?=
 =?utf-8?B?dmZrTXhrdVFNTWQzUVZjaHNBSExlM0RaamVkdEpYM2FTS1BrbVZRdUZyV2E5?=
 =?utf-8?B?Skx5cTFjTzJLTi92aHdQRUx1L3dPU0FMZm9vVmZMZDQ4enI0NFdrWW5zejRW?=
 =?utf-8?B?eVdPZzY5ZVRCb1ozemcrUk9LUUM0V2N0czJLcUV0MWYvZlRJRDNyalBmQS9F?=
 =?utf-8?B?MUNSWEdxWHVIMzJpQzhDdVBCZ0pMekZ4eEIxaHoya3l3cVgwZWpGbXhSdzAv?=
 =?utf-8?B?Tk45emVQYkJSaDkwd1FCQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac38efa-f80e-4f3c-53e8-08d952c7b768
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 19:33:18.1968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO561VXAiVDxuCm90XppGmlyVzwkCsN6G+PIr/RiGYeyAMeL8E++wscuQGogV9ZFhTdMFYorelMtME1lnk6mAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3191
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10060 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290119
X-Proofpoint-GUID: V8uYAVS3oIhHKQpd_BmFvye7W2TW4028
X-Proofpoint-ORIG-GUID: V8uYAVS3oIhHKQpd_BmFvye7W2TW4028
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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
