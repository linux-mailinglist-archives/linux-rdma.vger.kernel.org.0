Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF183D15F1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhGUR3P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 13:29:15 -0400
Received: from mail-dm6nam11on2111.outbound.protection.outlook.com ([40.107.223.111]:48968
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237970AbhGUR3P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 13:29:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POw/MQ6kV8P8PtlH68PRWgC6m97EH4hnV/LXT0n6KgkeyNaOHe5HU7xA1Hom+SzRmZ7Vi7BARJS5QSC55OCdU6OUYVCjmt1es7+vgT4j1TvWbwVUbBpBAjCvJTva+5+b4j7zM1Ao7zU7ZrOi3bgzv5elynKXX9xaxTsHc+UV0cX2KqIg448JsI8wv43+anDUbJCuY8wFHvKnPSLx9yabM1yoWMKUnDq2KqzwtHoiNY0BlyOJSwtKwK6H+U/R70tT4Pq/2uZHpXZjlPBqOsJqjWq8wezfNnWtP4P9QC700RHcztGZEc0RnDp/ssrUWDVNeaILECO/dGn5wu8/i8S13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lGORMh520Fly66N24WyPLQGkueVepUOI5MfCeu8oRI=;
 b=htTNgU4FCqdoPBdiF7MAZnkRKTBy1WTVHd+Gz3FPodKS3eMRjOUOlfZ3D0I8IZm/pmf8kp4P52gCB/d/EzGxnAkrjc7GA8IcO9MF+sVjiAwbGTUN2Y3504QpWarbSHZdeYWovoKap+4RRLBLB7rtrfLrg2e6Ux8CnqECBH7c819bF95qW6esi6KZGXqPk3l5nD/VIZsxk54hLfUFbPJSL69cAWdvUuzZERcmdFcJxH817gQWVsyGF2XFYzTQQcdDNrpbo2sxwaSyz6Q5SXl3OllxKSFXmYFObUrmhsnJrQcNeBiqmpAaWGUZAfj+V4h/JmaZNDKQ/W2su1iDHS4rwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lGORMh520Fly66N24WyPLQGkueVepUOI5MfCeu8oRI=;
 b=A1emsSl/VmhfHR9Vg2OIaMPWwfkrEelvrvO27vhK1LsxAB9VSUsADjuaiheKTjTN97PWqCTGkhrtbb2ux6Z2emrMQJCvPR/71R3EGzmF6NiAm48+2Z4665te0A0MgHyld44K7r1qTSxXVjVWgefQk5mZA4k2jHFaoD7vM/t7VX5NB8umgo94mw1+60cp5n6HGF9vjv7jYBfSJWD0tzoqnT6NmtYFVeVrgo7PkkmkgAXAmauzf839+kVx/ZY8MecdLKWLUHzD1c1FmWZWvt/9SzPsMMy2T1zYVL5vCsxFZ09WYrNU4WgIvTGcKu8a7D+5srBiPnBQDW0TUkNS29EZFQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6471.prod.exchangelabs.com (2603:10b6:510:b::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.26; Wed, 21 Jul 2021 18:09:47 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb%7]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 18:09:47 +0000
Subject: Re: [PATCH] RDMA/hfi1: Convert from atomic_t to refcount_t on
 hfi1_devdata->user_refcount
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
References: <1626674454-56075-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <cb4b1dbf-67b3-1dea-8f67-43b22c7ace06@cornelisnetworks.com>
Date:   Wed, 21 Jul 2021 14:09:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <1626674454-56075-1-git-send-email-xiyuyang19@fudan.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0114.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::16) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by DM6PR02CA0114.namprd02.prod.outlook.com (2603:10b6:5:1b4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 18:09:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b71feb49-1c72-42f7-b331-08d94c72b9c0
X-MS-TrafficTypeDiagnostic: PH0PR01MB6471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6471082FAA31FAC7029196BFF4E39@PH0PR01MB6471.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxSXSvCF1pjd9YlKgj8CRhdLm6p7eT4DrzdJqcNmA/8xa2HZ16owBscT5bwo1wNI3bweyE7btPltb3xqvQWKQKfVJ3E/PvA/kH4/UcoquFPpVav2JWv9PtNRl4vtvRJEKC63QzBo+kGFjovIeVUQTtYPAfxPdM42cE9iTntuGqQKCokZKeyScNq48ZqZ/RmonbaBX7BLTHg04ekt8e0ikEwaHm9WTJAAEPTI8S0UXvmIbr0rilNwnF2YlKmHQyUALtMUVYUBS1tW76Il/s3lSn+2K+cDcO5J6DOpmTug1rETrz+fLX8tp20FV1BhhzU2trbA1kBL12MS3YYTzlb4qcso4p307rq7e8DEL8G+wzNUHeQKQ1Ps83DN4ERa6rdCDDYAkxhtfVli9t76RUqdmPPI1ojvczAJEu7HE6bJoXhA2nLeCf3+6M+JGsBv9E/+w5E4lKcZl76TaT2U2XgvhiajHQA/ggBJxW8F1b1YH2V7ZzuYfgKHoJyc6yTVfY8hFedjq5cy3BJT5w99HVy0wdJDb3OmzdhWe9DkHtk1zfVg7yq2IZSj5f0k6cn1ToggePFXtMErNxGxjljdWJ0ZaHVyP6qg+ceC5Zbn5eQ77loqjY0zil8GCmess1hduGQhy8sr9FmLzIOobKAfiA4f4/tzOo9wGUj1SfZTcf+m2mzIvPl7Oz9SIroNo1LAEkjsmvGV3H5yKlHco8CYWS8vSJFxlhl3V2lOqAXP96ZIIT3sq9/2Ct18pw39sA5z5ddxbWCmsANvFNG5gFzGfnso4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(136003)(376002)(396003)(346002)(5660300002)(38100700002)(31696002)(86362001)(38350700002)(186003)(956004)(478600001)(2616005)(26005)(4326008)(316002)(31686004)(6486002)(52116002)(44832011)(66476007)(6512007)(8936002)(66556008)(8676002)(36756003)(4744005)(6506007)(66946007)(53546011)(2906002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjR0b1NWY01vME9BY0tZSzhVdG0yOW1tWXBnOTZpeDZiQjE0RitGcFd4dVlZ?=
 =?utf-8?B?YjhxeXhkTGkvVEhRenFrWERhazRHTGRYSzRCUGs2NU82bk9Xd2w1SisxVFR2?=
 =?utf-8?B?QVVtRFpkY2EzcldHVHJza2VKQndlV1dJa1NrOTZ0ZUFWdCt2MksxTWtBUW5i?=
 =?utf-8?B?Q1lYY2JDKzc0VUNyUHpLNENxS3lMSTN2WExRbVh4a0FETVJ1Z2Fhc2Y2cThD?=
 =?utf-8?B?TGZqc3ArRFJjZW5wRHdyTDQvdEozQjBhaXBiRlRWVUxIR2JoalROaUNKYnZt?=
 =?utf-8?B?a0dhcG92ZlV2TjRmSkIrbXVKL1ZOSmk2VHRzZzc0cC9CTDlOWUQ2dkRtQjBF?=
 =?utf-8?B?djNHeEM5TWFLY0VNejB1TTlnWGJzaHcwYzkyY3ZUeUp0WVUvZDVQWlRWLzM4?=
 =?utf-8?B?b2lid09WVnRtK2V3QXJnSnk0U2l1TGR5R21HdnVPQVBPSXlXUE0yMTE2a3hR?=
 =?utf-8?B?elpKdXBQN3VSb0JUUVlJeWd3NjAzUG8yU1FhL09BOFdoNm5RZFBMUE56UE1s?=
 =?utf-8?B?b2JLaW84cjdPcG5LSHlSZmZjWUZrdC9uWWZBZ1d3RGlHNUhEbDgzMFN2clky?=
 =?utf-8?B?RlFTaVlDemVJVHNvQk9hWEtCVjNVSFZHKzBrVkk0QlFZKzFaKzJaUVNsMGdq?=
 =?utf-8?B?Uld2dHIzeWRhVmVSd1NHRFhJQUlrL3N1WFNETktMbFNscVZSSngwaWx2UWMy?=
 =?utf-8?B?QzlwYW1kWjVrU3hQaDNmWjltdnRVZUVoeTNSWityVzBXRkpTQXRtc25leGhY?=
 =?utf-8?B?bWszZ0hsaEhZYzhySzFPNURicjROaHZkVjRPWHNYaDlhZ2Y1QUZtUE9pL0Ez?=
 =?utf-8?B?eGRoWU1TeDBvOUppck00aGcvQ0lMMUJQbi81NW5ZK3VTQ2h4bzlSNVJ6VkRQ?=
 =?utf-8?B?bDVJaVBNZnlJOU44TlBIdktaWldJWGx5UlU0VlJENnB2M2k5dFZreWlkREY3?=
 =?utf-8?B?TDF5N2JZWjRhQnZlMlNYY1YwNWJGRU5OQ2g2VWVaYWVKY21kRzM5OTFDMFhN?=
 =?utf-8?B?K25LL1JIdkVjUC9NQVNCRVM1cTVPUlBvTlRvdER0d0MwUjQ5UDdGS2ZKOVZE?=
 =?utf-8?B?WldRalRqSk1HclVXTkVod0lTNGdMNWhLeVV4OHZJQWtpaEJ1MDRxc1V1Um4v?=
 =?utf-8?B?dlp2ZGcvL0kvVjhwcCs5Zjg5UzgrMnhyMTFnMXJ2a05rZGYyRTcwNUdPekdI?=
 =?utf-8?B?bzlZRkdMVWpiS2x2TUFkUEJqQ1YxN0N5bW1BNXk3amhuN0IyK1NpbFFBZFhQ?=
 =?utf-8?B?NHhWT2VMeWpGRzdOeHF2U1QxOEhjYTVaN2NPLy9vWkl3WmV1dC9jektGUnJ3?=
 =?utf-8?B?ODIwd0tZM0Foc0dYL0U1a0JpVzErR0lDK0lNYXRVZDhuZnIxdklVVkY4RjhS?=
 =?utf-8?B?UHRtTmZRR09NaU0rRmNHZU1yRkpXdWNJNnBDUFNlc0JDTDZ5T1NRWkFYNDJy?=
 =?utf-8?B?aFZSMUhaWTN1NndPdVZwVWNVb2pkdUh2WnY4dWJRbEFpRzRvOTRhTkhwQ0Nu?=
 =?utf-8?B?RWZ4bE9ZT3lTd2NhN0NIUzNuWlEyWmtqNFpHVDJRNnJRelNZaTRUS05YMWdR?=
 =?utf-8?B?T2RCSXZ4SHlrTXFtSitWMk9sS1Z5cVBrMUJ3M3lSNDRlbS9kUExYU2doN1Bz?=
 =?utf-8?B?REc0UXRJTHV3MVBHbTBnZTJQdE9hTHEyMjczVjVkMThVWGlXSXZ1c1drb21R?=
 =?utf-8?B?OUR2czFxQU5TMVRKZWN4dG5DWnN4K3FWdUMrQlZLQTFpWDEwSHJHbUFwSTQv?=
 =?utf-8?Q?4hS/0hRuGqCc+sx1DjAWUtk1clVG8kZ2UrILPfO?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71feb49-1c72-42f7-b331-08d94c72b9c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 18:09:47.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrzhbTRpaHB/taWbl57GHZurbiq3X2VohkFHgmhoFQkffy0fBc+o7JlCQDdSb4EaTu77OKNRkw1/p1MkfjW3yozw3YkDvByDzwEaAoDP5BZ7mwhmXbF1hrpJbzBbJ6+B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6471
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/19/21 2:00 AM, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Tested-by: Josh Fisher <josh.fisher@cornelisnetworks.com>
Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
