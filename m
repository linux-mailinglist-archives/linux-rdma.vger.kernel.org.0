Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4B4865D3
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 15:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiAFOKC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 09:10:02 -0500
Received: from mail-bn8nam12on2126.outbound.protection.outlook.com ([40.107.237.126]:36000
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239599AbiAFOKB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jan 2022 09:10:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izyuI1KrUeHJSqq8wzLrCWBcg+eBXDl0F94rTjq5R2mG7sPiigZa7defGBwH5epbTxkIgwbyuqT5vfV1Wsvjp3xiJFJkKOJ+8Picw9mABqpty2yg3VCL/jJ7zeLu9fOD9g9Z4VWdL5XMFOz/oQvl58UuZLpLmX8dMXznGEJs8/030XLxBHJYA5xex99Ct5CpOzFfA2RzGI/XqErsFNKmCMJG0qFD3zgzdSfeJb3UXma354QvmS0BszrzjMhpPfeYWNnqha8+I/xh/U2Ftdn9OrvfRvT1+RRJSr5G8NEoBRNzMLA8trOfjAQplxmcUlT7X88WWGtWW6AovMKgqFVwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj8DBDZ9e38lnUMMbXcosqDcRXLwycPQ0TftvH+hSxg=;
 b=CHO7bIrawtVEiPcr52Hs4cUri/jfiKOvsJg+CUmq4LjmmS6zh6TmJvzDHdpYVhqP9RLayE2J3In4vK830Dki8XrBsAyBLwJW4+bDrKHFqmqXHms/dbcPLeDhgA91uqkQAIbDKJjG42aS7Rk20tBMBb3X7dw4bq0Ba3iafvPdd2UCd3GFUHzDN1mBAXmPbIgme7VGfLHnwEmhdeGK7FJWp1jmIek7bphWjMVZkFq4h/5kvvlRqVNcJxm7ZWM7of10QV/H/poya1tbaNttZfKAdLIXSXuZDKTMg0FKS+k/7javs+Dp9lPuF7mq1YiUz9qKNZwUfjZ4PTIM7r5AihfYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj8DBDZ9e38lnUMMbXcosqDcRXLwycPQ0TftvH+hSxg=;
 b=YI/QvJ5uVsvpPvk5KMBI4o8LAAdZNm7t2/xlBQ+5g4BLKnk2VGrLHQrs228MHFxG7tm+ozpRBOKITxVGQM4nScKMTLvBl/UYgiWOsVqlIRD0lWag9n9MEDvTUfYJbmFR/0KZMG7L59OBWhInGPccC1dXX9M0VZKwngymkeR5PBMiqP5231PmxSos0alLyRybhMIx5CEfIivx0iDRegbFGZol4kLg85IF96xsfaCGiYVkHYWPNsxEbdrnYHO6VQiHdEkABD5AueF77eeR1m0pCILt8agDA2EUEWss3mll3jJOq5tYa1n0wtbZq3JJKFz2fiufHf5ndFtfI7PA3Kqfnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6213.prod.exchangelabs.com (2603:10b6:510:9::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Thu, 6 Jan 2022 14:09:57 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::e86f:7454:5011:71b]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::e86f:7454:5011:71b%8]) with mapi id 15.20.4844.017; Thu, 6 Jan 2022
 14:09:57 +0000
Message-ID: <c5b07e17-af3d-ba89-1cdb-4471f5d9f914@cornelisnetworks.com>
Date:   Thu, 6 Jan 2022 09:09:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] IB/qib: Fix typos
Content-Language: en-US
To:     Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220106082722.354680-1-qhjin.dev@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220106082722.354680-1-qhjin.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::20) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a349f283-d052-4654-b8d2-08d9d11e3850
X-MS-TrafficTypeDiagnostic: PH0PR01MB6213:EE_
X-Microsoft-Antispam-PRVS: <PH0PR01MB6213A885D39A4DCA04AFF882F44C9@PH0PR01MB6213.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlNXEsO9NmoWEgv1EJJUSrrCDXi/CschzHEgHDPOj2AMYVL3lJYtKxckszxm9+R7StMwi1sY0jnx2JMOfZqJ7680OT+UlAan/mbIrH3uARDS7f3tm7t57QTpOQongeQLu1Aj7B+PSAPIc+iwhmAB5VpRQ3ceTJBNVRxt9VAfLLoNC/uUkK7dwYP+OzftyNvO1TYTMenqNgtU5uLb3AMbuhGQCa8n8b6U9qbg5kucbd3jDF/0Qm+8xb4P+rCv5Y+56gy+02y2XdtXtcjzCP2kNrTnOjetxzfPAhGofxT8I4KUXzFekx6P77aGdNolQcdniZdM1z4Zwln5LFHClL7nMsX4hCm67naOWqWx2qdqdAVRp1UIrcocLgONonFz7VKUb70P9Ot8P7P06FETnoZes5TNQaUyEAYcRGgGWU6xo4L3tkapGbCtsu21b1I8Xp7B46R76Kv6jqLo9ptCdO3xWBm9YlKp3+udbqukP9+m/YWdrFIDqYnPFVFJkvDe73+lM0nci1UW6PJkqPJQuuF4CuqlkohTJrAIMGD0Ep2CuaJGg1Cl4Kc5KAtso8hY33MEXPF5yGOFUvJGovgvEXQc1GELZa9QWTWg8eNvTQc4LQCaIOPX/TFG8NHJdYlaUlKrmsZKOSovMHIkdGWc2GqqXgXIOktktVVRC6q6s4hcXSqckdNlRGmjtyTB7kqjZtx04R3fYrR76Fq8lVYx6LEhgOPQ7CHD5cTzcj4hGheSCh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39840400004)(4326008)(44832011)(6666004)(66476007)(66556008)(2906002)(5660300002)(6486002)(31696002)(6512007)(66946007)(86362001)(36756003)(558084003)(2616005)(508600001)(26005)(8676002)(6916009)(186003)(8936002)(54906003)(52116002)(6506007)(53546011)(316002)(31686004)(38350700002)(38100700002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmlBRi9rbyt3bmF4TEdpT0hCMW5QNEZZMU9pUTRBMGlpMXcxYlMrSUhlNDEr?=
 =?utf-8?B?U2FVNW9IUk1UaTJQdHE0VnJKYzF3NnJhb3B6SDRYcHBrTkZib0xxVS9oYlEw?=
 =?utf-8?B?ajV1TWhYMVRCZ1RKVmVHL0VJa0ZMZkh2Z0hMaHoxa0hWL2RRQnRqSDJkMkVN?=
 =?utf-8?B?TmEwOW13bzloL0FiOUthR2pMeGl3Y1BwU1dDQVBWZHRJbkhBNGtReEFtUUta?=
 =?utf-8?B?TUFkWWlhRndIMHZ0dXhuVHdQQkFWMnFmZjJubFVadWJkN0xFZ1JPR3lKNXU0?=
 =?utf-8?B?NUdXLzZuVWVsVmlkdnpPaXJ5SnNWcWpSZDZ4bFZ6TzR3eEx4NFJWVzF0U3BG?=
 =?utf-8?B?YW5YRklYb0k5VnVOUHZZeUtQem5zRHB3UnBUdzZXWG84RzVMWnJwL3kyc0pS?=
 =?utf-8?B?N0dNcFBaWDRRa21TeTNCRjU0KzdLNTJFU1RPeVUrYkZOOHVKUVA1NjBTR0N5?=
 =?utf-8?B?UVRJcTIrWS85ZUQxMGg1WEdrcnR6OXIxUDZIY1dVQ2lVTzBydTY3aFE4Wmly?=
 =?utf-8?B?STVkVnB3L0Zsd3c0SFFYWSszUlVGY2FnMGx4aWNtUlBQSmh5K0RzSXMvT2Ju?=
 =?utf-8?B?TDNjU3dFK0djUm0wTkR0UjVnVEJ1ZXB1N2FnalgrVjhIQVhQL3B4M1B3V1Fr?=
 =?utf-8?B?MlVzU1h3eERTN29CWFZ5VnFVVDNBYXJ2Yk9wbjM0cytzKzBoSnh4MWNFU1Jr?=
 =?utf-8?B?Skk4T2x6aTZDYWZ6dnF6Zy91bjFlc2Y3d2FMVERaVE1wWEhvMXQxSnVFazEv?=
 =?utf-8?B?UERtbUVtSXEza3ZzSnlRRkV5N25iZmhiSXZOdUJsbm1sK1lSbWhKUEYwdFRh?=
 =?utf-8?B?U2dNSkFLMTNQM293aldVTlgvTUovUCsyUTkrMG9tUWU4RzcvT0ppOUQzc0t4?=
 =?utf-8?B?eGVDb3cvcmR1MElLdURqZlRwS2FJL3Z5UGgyYjloOGJCUTFhVHg2ZmQxYStq?=
 =?utf-8?B?dzdCU255dlNscUdHUWI3bTVWUDJkbWVMWG1taHNESVJiZVhXb1loNVEra1VT?=
 =?utf-8?B?bDhUUFcrU0lkOVcxZStHVUVZNnVvS3hQanJtN3psWXA2Z2NZQTR1Tk9UQ3h5?=
 =?utf-8?B?UEI0MjRGc0RhNkFEelVMQTZqSlhyV3o3cUF1WFpMK0hrTUhac2RuOHF5SWw3?=
 =?utf-8?B?azJUV1Y0cktvazlodXNpREY5ZXNxdjZpbThZd2g3SXpxQ3BGaU5rVmdCamYz?=
 =?utf-8?B?eDhJMXdNYS9OYTY0SGtYZldmUk1UQ05WUk94dlZBanJqd0FtTklRcTZIUVc3?=
 =?utf-8?B?Wm1XQlVsMFp5eG1iRExGOUdTQjAxU1BaQkpCY01VNTA1bi8xS3B5Nm42Y3JE?=
 =?utf-8?B?VjE3RGZHTDlhbDdmTCt1U2psQWR6MW9IOE1ZZjR3RGhEZ0hnNU96UWdpb0JO?=
 =?utf-8?B?YkRXRzdvT3JaK1pFVU9LazJEVFlXMzdmSVN4ZDNsK1VIOWdpTjdRZWdQOVVG?=
 =?utf-8?B?R2s4ZG1sU1dsYWh3bk1SdGpISkFKdHBGSGh5U2RYbWZRSlNjRHMwTCtEc0dy?=
 =?utf-8?B?RkU4MWFXMC9Yem5OcEh1SHNrV2JhSmVCRi9TeFBzQldxSkFMazRQdzYyZnlj?=
 =?utf-8?B?SzdrbFVJSC9SRFE0anFMYkRLMDQ1T0t1RG1QV1ptMEVyUzdVMkVtYUg5c0lo?=
 =?utf-8?B?YXlSNUhtUFQvb29kU0tKVURsMTNhNVFXbENuZlU3VUdHOGE4Z2NIVmlxY09W?=
 =?utf-8?B?ekZaaXFoeDJOTUF6OEZJR1cvbkJzZ1J0ZXJZeXVTUnlVUGsvTDh5UisxS0lK?=
 =?utf-8?B?Qjc2Q3Ztdk1pVXgvTVdtdEo3QnRobXdsaUMyYnNJdkJ6clhRM0tEaDdmWU5s?=
 =?utf-8?B?Y3llNyt4V1NiNVJSVEdXM2hPL2U2NjFhTk1heDdsZWZmUUltZkNxWUVxbi9Z?=
 =?utf-8?B?Z3RVaG5YLzVYbmZwb0xEd1lJQ2ZOcjFXZ1BQUXBmZmJRK3JyZWNxQjRVMHVu?=
 =?utf-8?B?TkZpUjIyVmRXRFozOHljVzZnL2RJbGFsdkNNUllmWTRRWUlET2wrZzZvUkZs?=
 =?utf-8?B?VHBSbVpKWkw5SmZVa05JNzhobFAxeHJBOGxOTE1YT25udlhBTGprdXU3aFJx?=
 =?utf-8?B?b0ZDNWVXUEFqZE1GZWhrbXVKeENZZnVRSFRpbVg0ZlZpRWNQL0dMNi95QzZn?=
 =?utf-8?B?cVZJWjMwMjhlakNISDAyVEUrNUlJOUFGV1FGSTllNllXUEVkb1dwdUxtSUdn?=
 =?utf-8?B?eUs2ZDlwb0F5RlJOOHR6VjlVNnZhVUM3QXdqVFg4bVovL1o3NUtQamIyalZL?=
 =?utf-8?B?Q1JsNnpvYTl6dTYzQUNrSjUzRG1IMU9MWUxyK1ZHcVJvWnZma3BTM051YzBL?=
 =?utf-8?B?d1pyYkV6MnBzNDNCMklMN1lJcGd1MGFDK24vSHMzOFo3cjkyRm5qUT09?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a349f283-d052-4654-b8d2-08d9d11e3850
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 14:09:57.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ySIfsM/ZE9Erl5bMwZim2XOPNAuCsVz3k8Hc5ZTXiMEYEZdZrbQtRubA0ntCZXYsXAUuJFOUGoU7FEddYAlYfHX1eRVQXV/yTALBp17ypKdPVlbQwJIu6KMgZy00sR8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6213
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/6/22 3:27 AM, Qinghua Jin wrote:
> change 'postion' to 'position'
> 
> Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>

Thanks for the fix-ups.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
