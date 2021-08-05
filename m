Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295AD3E0D02
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 06:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhHEEKo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 00:10:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54488 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229705AbhHEEKn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 00:10:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17545qgv031565;
        Thu, 5 Aug 2021 04:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qlIeax/zgC5P5Lnxs5qh95VoWW5AVDvoPpgO3KQ4sbw=;
 b=qCkBJ3KrAVw6AfVuY7DhFwf3X2/cpOgGkv2tiqMWyGC6XJAUxKb+kL7YBftfXTO33vwz
 UAwBNWGiW/ApKLTy8SPImAF+RUmbv0Hl7j/YLsDy1dXW4bhI/z1zSb64xSs7rQ12sBpw
 6AZyfL3PM+DXuY1X9IqiUnIeaLbbKJmwQHGUFAEBF59NC1qF8JK5H5UEn5hWBFaSXw+c
 hbtQiyu1gpj9z2WH1J2OKhPSonkrgpzLyyvX0iwtRJDtuKHjrVs9Z220yQPMpWMFp9rv
 4LDtdCSjrntrm/cHEVVrg7Zv6YADM3owBYPrj6HbGxRZPNwCR8M9RRL6Iz8qq99KsrTu bw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qlIeax/zgC5P5Lnxs5qh95VoWW5AVDvoPpgO3KQ4sbw=;
 b=z4IvInepgMLdcDjVjb1GrwhQG5ukIKcOwYIw+geOUJm1iUZZaewrbfBsmLgLWQlBPXKs
 KvAll4pvQ20tha1H4KlY6AQ+OYFUdBNAeTJVOU3P+t/LhdqeXHJwmpZ/YlaLhbU4WE/b
 dD/TUJ0xR20poHSGS5GZKjDZYosg4nJwR4SXLRhLxvpcF/ZRRukeiTrNE8rw4I+wWUIS
 xjuLg1x1rcH4ZbVSKiWEVex7nzbFF49nUhhjrVOhsbWy69I5sZiFrTdqq2gdIkfMcmMc
 QQmioDi6UKre/GsrtjqYfzj7Cho0OLOf/rdAIwDParSoqByYryPiiLOkU1mW5/lJlVxv 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7wqu9740-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 04:10:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17549Y68052852;
        Thu, 5 Aug 2021 04:10:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by userp3030.oracle.com with ESMTP id 3a4un2xutr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 04:10:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDy+1vFu0HOjjCqqPNW2BjY1Mf9tDnOtFnywnZkFaIvDl8IP2fMHVz4thQcSxLXTNQ0VvzeuewLG9tj1EiqJiyHE4OMuAfvHiZB30mJXsE0JISsNBnVhCKOtAog8TgB0gye0SNAHM0hIZsep9WLvuUmlTuznG2Gtil5hyLNt/XTP3psJQh/a/vMkBLNDuneCGUzhWKXOoBber4I0ky5GPVFljCYlaKN+5rx5Wwt2jE+Q5Kwb+0SN5SkwgxXgN9Z00bKp9tgzXN3hsWzc/6v4Osn3hjozJ8mFwAsY3m9gClmJayV8ODYh4c7g2/Ec5Y+AqAp3WGr8g6F/obD9MHKwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlIeax/zgC5P5Lnxs5qh95VoWW5AVDvoPpgO3KQ4sbw=;
 b=Ybm0H5NjNCM6bVzSLtdjMqlS1yP4Lc4LjKnr+9EtH7VT+j7xgE/znH2FJv6eQ17KDLlXdsDngwEEuVP6CTXi2g3OR+/FZB4ymAHFqOqQJmDODudRJXk5tL87V+9JjGs6Emv+DhxR6wiszlxG1yuPGjyuDGGG3cfdNZ/Ff9pZJMWMfPhiVJf8a3vCXXZxR5DKPhxUqdPlMd3vHMJisqzpaf49Wip9g+pNuMXrkpPmmSj24RXbOPWslSrc+CTOhyas68GVBDF22P/X1QBiu/CfyG/mNr+qnP8U77Scez+Kj1t2ZpL/1qkL0MJqi0nP6ynjiRsNW6IyrhQHzPOplRanPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlIeax/zgC5P5Lnxs5qh95VoWW5AVDvoPpgO3KQ4sbw=;
 b=ZiJSweAQr9S76uKprm+/P/7kVV5OlXbSUU5+fqZlr0JvS3oIQs41ytlVbV4h82I3EnszXICIRnP+0lpXdTVqOZSs7Dyu8Z4PcFYLUK4X6b3kn+dyqqgXXxoB0LZnAkeW3wEuhxRa2OVS5sKQ2VpD9lTIKhMX+WmKRzaSo+YpQwE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 5 Aug
 2021 04:10:24 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::588f:a774:17de:1d1b]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::588f:a774:17de:1d1b%3]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 04:10:24 +0000
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
 <7a1881c3-4955-5a24-7f90-4d60f2a607a8@oracle.com>
 <CAD=hENeupnOm1Jie+VM-t7dgEAtTp85HXjnFB+tj6bPihp5JKQ@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <37d69ea2-ab29-624b-1d02-44890cd078f4@oracle.com>
Date:   Wed, 4 Aug 2021 21:10:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAD=hENeupnOm1Jie+VM-t7dgEAtTp85HXjnFB+tj6bPihp5JKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN1PR12CA0098.namprd12.prod.outlook.com
 (2603:10b6:802:21::33) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7446:8000::8b5] (2606:b400:8301:1010::16aa) by SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 04:10:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e7b80e-65a3-486f-afa8-08d957c6f31c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4814:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB481437D301B59821D21E7360EFF29@SJ0PR10MB4814.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: El0dLrc05AWr1gnPHl9Js6FJvs7AgVbiUNwgFGpCpDMdmda7g5dA+SfzllopN1G/zMCf80093sdYKP/bRN+NyTyRZYofY4q24LrkY8Zv5nl6s9devbYJhkZ440xF1tj+co6+JO8WipwvMzLTTcxSbBRNTVq0piZq7BFlLLJlu0XJj+tN+HsJSqnIbj3+DgixIyIxlCIzjN4p5p6MdGqFArHCrSFFJCYcRL0epJBOo0oHvhGMtUQAhuzw7heQEwGkk89Jvk5BaEM9lu+d8TNXc7uvd2ovDnLwIYYym2wFPHz7Ao0zO82fJ2nOBnAtvtMxULVKCvO14rdajBpCbI4sw4yt2M9qOU+VsU2O7dli2wakjMlwmPxz1HwuPAhPTqjQdyBU2/jSka/5VMiIUg05hLSyLMV4Z6uPpf0hziHleYfRYcLtUBbuQe7CFeTN7Lo5HMb6IHaP2Z/p0kugyS/pC/ZWekGf4ozCBbnRNo1tAm9eFGX+va8asKPBEocZGL8O1FyjUz3TIAFKZAnTJWuTBc3c95AhgB5XY+MSvdI//Mdm/7+imns5jlSAuhs3ojTKTP7BFhnumUS9GkSLNUsCZYtXJ00cYSnz5NVN5CJvq8BnIDhGXkbrDNiEK6yzjRLBmbu9gU7MD3rBh3CFTa5OYp1/uP7BY5PofuY/ZKL+YrM2WGKGztj4stiI1C9Sl9cBfT+aagyL8wAi7rBDvWZpZo3sXz5eYacKTCtPvwcpZt69Xet/Fq0/F3Vu5JKVozKB/5YGflQXgXY0DVTxPS3Yi1EZe/Zrlj1Y+fVIsW/Tuh3cn8RW5uWYvanqOgKIfq24
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(8676002)(2906002)(8936002)(2616005)(478600001)(316002)(36756003)(38100700002)(6486002)(6916009)(31686004)(86362001)(66556008)(53546011)(66946007)(83380400001)(966005)(31696002)(5660300002)(4326008)(186003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWNPTVZGV2F1cGF4TFhsNWhzOUVlQTZLUVpYSjZ5eWNLWW5oekZpQjgxMHY0?=
 =?utf-8?B?RmR1WWFzUGltRFlSdjEzNHBmZDJIbktZdjhRcUpmT3pnSGFITXgxYldTRHZP?=
 =?utf-8?B?akM0NkZpY243MDg5VmUwdXB6M0VINU81U0JJeHMzQjZybXZKYnVqQ2JwY3I5?=
 =?utf-8?B?MzFmTEhGeTZPdWdnOUVYdzhuV09KaitQZjdMOTNXczRxODVRY3FHWEVDZVhw?=
 =?utf-8?B?L280UUZlZXVaWm1KMW9RRGhFTW9Ddlc3dE1BaFdpcmE2RFk2WnEvVUlVdmxU?=
 =?utf-8?B?TlV3TlNFa25oTk4zOVRDTGxoL3lJMkhWbE85dTQ0VlR5Q3ZrT2ppRHp4UFQ5?=
 =?utf-8?B?OUs5QzN6Wm5Eb1BaeTc4NVNpYmtqMDI3UnJ0S2ViUlV0VUd2MzZWVkZESkJW?=
 =?utf-8?B?azJsWnMrTTliVWRlaEdnTFZXQkk1WU9Kakp4M3VzQlp1em9XY3FZTUwrNVhF?=
 =?utf-8?B?Z1NjaVYyL3pEK1FZQXIwY3VvRGxlREwrV2FXYTVvcStZTlhjVW9BWnM4MytG?=
 =?utf-8?B?eGFHbDdwVmYrZXZ4Ky9BZlIrUlNHczA0N1cvN1U0WklhVDRnSUNqVXZOTkpU?=
 =?utf-8?B?TmpIMUNVTHI1K1AxcEJpd2k1UFdZdEZ6d0tBTEJTenBvSWtnUzN2OUQ5S2Y5?=
 =?utf-8?B?NHVheTh3N2dtM09KQ3BVNXQrSXYxNi9SckFtcy8wQ0VFOUVyN3ArM1BKWklS?=
 =?utf-8?B?SWVlRjgwRC9DSm5zRUxmYjZSNThmSFg0cS9lVWNIWTF3TzI0SldJUjBXK1BF?=
 =?utf-8?B?b1BXTUh5VGxSYTJyTDU5OElEOWY0Q2wrdTQ4ZStYSnYxUGV6LytZbTdxZDE3?=
 =?utf-8?B?bkkybzYwcGdmcXdPMEZleGc1aVFZUUVwRnVHUXR2NGVweCtMN0RHb3lHNW84?=
 =?utf-8?B?d3RpZ0JYQnlGaEV1a0JpQ3NxNzE0L1JYQ28yeUVvR011TGQwdXhXQTQ2L1Jo?=
 =?utf-8?B?UHd3YWxwcm0yMTRwRTVWeGhrTzl6NHhPK2lvS2hPWmFhREEvRStYaW1iMzJh?=
 =?utf-8?B?TXlkUFhiRmQxYmE4cWNucXE4Sy9WS2FscjhUMCtmbTRvbFBFckJ3R1JtMmNH?=
 =?utf-8?B?cGJuR08waVVydVVBMmNlZEQ1M20zYUtQdzBwdWFod0l3SHJDbFptRWo3LzRp?=
 =?utf-8?B?MzZXUHgybER5aFVSOWpZTDNTSWhDOXErRWZucGZQSGIzRnJ2WnpBVVo2T3JY?=
 =?utf-8?B?N3Qvd3Zxdy9GQjIyS3JwQitpaUNZdXJtbHdWNllrV2JHUldXZm5qZTNaWUNT?=
 =?utf-8?B?eXdIYjRKNTB0Qzh6Qm9sZTdYbmp2SjVIMGpCRlVCeFBvTDhTMWdLN3dnZDBR?=
 =?utf-8?B?QjN3bS84Y1l6ajhvUlhMMmRVVWMxOWVvMDc3dVBNN3F2cWUyYWtGMzEzdDk4?=
 =?utf-8?B?ejQ2T1c4K3RaQXJvK3VIcFczSzNwbXZKb1VWOVVKZlhpVnZFNGw3NEVTRWIv?=
 =?utf-8?B?L25mYmN4bG9EWXlxRmhmVzRpK2QrUkpCc2R5SEdYQi9QTVl6T2thNkpiMG9O?=
 =?utf-8?B?ZmFpTTYvM3NQTUlVeXVBampKNWJaUm9GcGRxclVrUFRvTEd0cC9XK2N3SHFH?=
 =?utf-8?B?QUpDWTJETDdISWd5aFd2KzZjRHpDRkpNQmRNSG4ybVVUM2pSb3VhTTJkQWlp?=
 =?utf-8?B?dXlydENacmdCOGlUb2RmNHdNRkJlaDV0Um5NY2lnNU1vbXdIWFJJd1hrbjdY?=
 =?utf-8?B?ZkxtQ1UyeE5wWjhySHNYY0tFVWZ1VDQrcmY3MXgrZ2Q3N0hKQzcxRnF1Rkw3?=
 =?utf-8?B?UEswTU9YSldsR1FDTWpkSjBldzhBbjliSEpzeXVuc2l5UWdudTFCZDJSRE1x?=
 =?utf-8?Q?agEze+S53BeS8lf93BNZFxBWOcyKZb4BTFpik=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e7b80e-65a3-486f-afa8-08d957c6f31c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 04:10:24.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KjyWiseIqUIW9Lky2I5nz7hRpGrrGb2B9oipdO4kyQ6Nr3P0NJhehomKQSW+4rsPgvjz0eDahhQenLQRWaXYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050023
X-Proofpoint-GUID: TbiOPH0Ffh1akp7HuRjMCdvZoDYkZrB2
X-Proofpoint-ORIG-GUID: TbiOPH0Ffh1akp7HuRjMCdvZoDYkZrB2
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/3/21 7:21 PM, Zhu Yanjun wrote:
> On Wed, Aug 4, 2021 at 10:03 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>
>> On 8/3/21 5:51 PM, Zhu Yanjun wrote:
>>> On Wed, Aug 4, 2021 at 7:53 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>>> Hi Zhu,
>>>>
>>>> Any update on your testing after applying Bob's fixes
>>> Do you read my problem carefully?
>>> I mean that before your commit, the whole rxe can work well.
>>> After your commit, the rxe can not work well.
>>> Please reproduce this problem in your host and fix it.
>>>
>>> Zhu Yanjun
>> You posted
>>
>>> In my daily tests, I found that one host 5.12-stable, the other host
>>> is 5.14.-rc3 + this commit.
>>> rping can not work. Sometimes crash will occur.
>>>
>>> It seems that changing maximum values breaks backward compatibility.
>>>
>>> But without this commit, that is, 5.12-stable <-------> 5.14-rc3,
>>> rping can work well.
>>>
>>> Zhu Yanjun
>> I am not sure how you made rxe to work because it did not work for me
>> and neither for Bob. Since then, Bob has posted patches for the issue. I
>> also posted that my changes work on 5.13.6 kernel. emails attached.
>>
>> Even if rxe in 5.14 is working for you some how, please apply Bob's
>> patches and then mine and test.
> I have already applied this commit
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-rdma/patch/20210729220039.18549-3-rpearsonhpe@gmail.com/__;!!ACWV5N9M2RV99hQ!b2c47MGvP_kCr0tkQgySPZaB3QX3DMeh4l_iwAS3IQHh9R589oF9BWrcgftcidGA$ .
>
> And with your commit, rxe can not work well.
>
> Zhu Yanjun

I am not sure how anyone can claim that the code works without my 
changes. Rxe in Linux 5.14-rc4 is broken due to following change made to 
rxe_cq_post() and will cause panic or corruption guaranteed.

addr = producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);

It should be

addr = producer_addr(cq->queue, QUEUE_TYPE_FROM_CLIENT);

The following function also seems wrong

> static inline void *producer_addr(struct rxe_queue *q, enum queue_type 
> type)
> {
>         u32 prod;
>
>         switch (type) {
>         case QUEUE_TYPE_FROM_CLIENT:
>                 /* protect user space index */
>                 prod = smp_load_acquire(&q->buf->producer_index);
>                 prod &= q->index_mask;
>                 break;
>         case QUEUE_TYPE_TO_CLIENT:
>                 prod = q->index;
>                 break;
>         }
>
>         return q->buf->data + (prod << q->log2_elem_size);
> }
index should be returned as it is.

The code has changed again in v5.14-rc4-22-g251a1524293d, so now I have 
to try again.

Can we please make sure that the code is working after the application 
of each patch or else it is a moving target.

BTW I liked the old code as it distinctly said what was being returned.

Shoaib


>> Thanks,
>>
>> Shoaib
>>
>>
>>>> Shoaib
>>>>
>>>> On 7/29/21 5:34 PM, Shoaib Rao wrote:
>>>>> Thanks Bob.
>>>>>
>>>>> Zhu can you please apply those patches and test.
>>>>>
>>>>> Shoaib
>>>>>
>>>>> On 7/29/21 4:08 PM, Pearson, Robert B wrote:
>>>>>> I found another rxe bug (for SRQ) and sent three bug fixes in a set
>>>>>> including the one you mention. They should all be applied.
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>>>> Sent: Thursday, July 29, 2021 2:51 PM
>>>>>> To: Shoaib Rao <rao.shoaib@oracle.com>
>>>>>> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>; RDMA mailing list
>>>>>> <linux-rdma@vger.kernel.org>
>>>>>> Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values
>>>>>> used via uverbs
>>>>>>
>>>>>> On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:
>>>>>>
>>>>>>> Can we please accept my initial patch where I bumped up the values of
>>>>>>> a few parameters. We have extensively tested with those values. I will
>>>>>>> try to resolve CRC errors and panic and make changes to other
>>>>>>> tuneables later?
>>>>>> I think Bob posted something for the icrc issues already
>>>>>>
>>>>>> Please try to work in a sane fashion, rxe shouldn't be left broken
>>>>>> with so many people apparently interested in it??
>>>>>>
>>>>>> Jason
