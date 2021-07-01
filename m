Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97E53B944C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jul 2021 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhGAPxa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jul 2021 11:53:30 -0400
Received: from mail-dm6nam12on2098.outbound.protection.outlook.com ([40.107.243.98]:61363
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233239AbhGAPx3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Jul 2021 11:53:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEpIL1zlmQqDrOdZdQyN/YMdCvjskkSQO6R8HWa8mG/cy1kdD5FEFvnvERNq0Vqa2fqmqXEkyNk2JpZ9UV6eq4mlRwueM2tAko32d73HupRBqqB+xBn7HcZNVOCxoRfc4f4P1Dge/K8SuOPirnKWsfzmBeAhzwvU6fKHqohMo/2IV5I3IDJWQ/w3lRTA3+76HGBkHLxiz04FLDv2iuLkbzWChPqSwW2iQb6vr8S/XHyruM2fUg/EQnXOk+8NPmOA3vv/R38G2/kb49fxU1alaYTgHuWusY8uq3TxF+ASCS1HrsYot1oiwAR0xA6z2RBTS4wryo9rABl19cNX86jhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJxDKNMhzNqSsJ4qXMlP7KPnkgTf704OB5b5GVpZ/Mk=;
 b=SEGILUriMnQhn7Qv8zpHrLshDmWSUdeecHqFKBfFYoIGtqCdS3/a5w8nCB8OOF3nPCvpe148UDRsMSzdXZPTguK26jmdbLFLiPa8YxX0RZdFDbXicOjb4DoVJQi8O6Y9DGAIAU848m9irXpBxl1In/vPUe1Ilw07rujClGgdr+dEa6bscf1KiKaNaKY8iD/spFtjHz3+DKG7Xbz4ziOZ5GdinLKDRRgEPUZOytbFCuFVk/intDlJ+IIeIB1oFRESsxTJxkt1CoDCeu6VG+LYKX4DOpL7rpOk4VHKmiqmUpSfAz90Uvw3+k681s57wu1BZ+gs9rJiedw40cgZq/zZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJxDKNMhzNqSsJ4qXMlP7KPnkgTf704OB5b5GVpZ/Mk=;
 b=B5RaqLZEpTx11L3Cuxn+aC1lQhRoauC1OLfjkOnaYiCDFoalF6OVJ/zZoIC2jbo9+uomXpUB4oURa8Idm9cBED0xeCLrkPMLJDhMFMjCdbDF3RO92tlOTyGY/aoqPm7bOZOfJebLgVU28UXztE1AzWsF4z26k7dZEYeJjGk4SiJUIDIi51FkSO8pSoWkAO2oOl0/VJaebEdRag0Cg6W8CxoBTB9JxXN4xmRhEcj4c0U6EYAhixGxDd4lmL91cqsKaO+MV+0VhYb1kLf4YyeisocZW/swEOhiICZYTjogL9Ziw343XtLQFEhlzcmJcHSvtQBHhU0I6FHD2c2DAk6m2g==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6796.prod.exchangelabs.com (2603:10b6:510:a1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Thu, 1 Jul 2021 15:50:54 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::dd22:758c:d859:8f03]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::dd22:758c:d859:8f03%9]) with mapi id 15.20.4264.027; Thu, 1 Jul 2021
 15:50:54 +0000
Subject: Re: [PATCH for-rc or next 0/2] Two small fixups
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
References: <20210701154318.93459.18982.stgit@awfm-01.cornelisnetworks.com>
Message-ID: <41f90b65-8f76-9559-8ea9-54e7a22f5627@cornelisnetworks.com>
Date:   Thu, 1 Jul 2021 11:50:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210701154318.93459.18982.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR16CA0031.namprd16.prod.outlook.com
 (2603:10b6:208:134::44) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:208:134::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Thu, 1 Jul 2021 15:50:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4e3a06-468e-4527-c438-08d93ca8026d
X-MS-TrafficTypeDiagnostic: PH0PR01MB6796:
X-Microsoft-Antispam-PRVS: <PH0PR01MB6796937CE18FD5149D06FC26F4009@PH0PR01MB6796.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ulnHPakbb/cGS4UeE11jQ9Bf6IdMsKzRcG1nw2YEm6ex5d83itkhlL7U9TQIuTfPWVShZnEtWEoHR5hkboaln0dkB5WPBixs7N/VRkG6k+DgGBCwOJh9nKEcWGFesT/uFSZUdWjYigc9/n/lyRHO8n22E6yOcosEUl3FJ7rcJPLl5GYoJeKPtrQw74uQ+goBOGk8EiDqP3TUwwpD7uHcbT8jjywD59aEDyw1ZibscMQh9UPJy564R9RLSvYKxbSwUHPC5P9l6R1vZFf4VKMJRSxPzK4LHyrJNH4SKKgX/jBTYMUsR8P54F/krnbIxvmu5yM551Xfosq4kHvXK67LVXhix1YScFMPV9UD3YhS9aWFyjYiRgk7d/N5sZGxriRdKc22iyRNjn+N5LMOMD+gLvyqG5EVfwQj47okYSrlDEzO2nYI0RUHfpDTWu5sttEcAd5dh3JYHWAwR3+h94aYqd5GUrgiZFGu5KBlZSBc28ZlXLSLgNFP28r5EGX/Ehx1Qec25FPHyNIObn7AINc38mCHkvU+x4ylhZsKwRrHlfmC4MWYM9JaVtkd7PqJ634KLGH7bmKNLrsiqb3ltyN28+bVzHZcMZcE+iQdUBO1ZQxdH7K8OKeMwo7+F/3Io6UwMvbLemje9iPdwZd1YFwPIMmM4mZ4zGdqfQ/jXUI+mAUp/W8rmmg49+KgrXNlNjJavxJjHw/qCMFM6Ds44vHX4j04+WoZYWBMXnvLQa+Crlw8z5j1GB4q+HkiWZbxmy800M/8tzxELnb7T7xFCg26g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39840400004)(376002)(346002)(16526019)(6506007)(52116002)(86362001)(186003)(26005)(31696002)(4744005)(53546011)(38350700002)(83380400001)(38100700002)(66556008)(36756003)(66476007)(4326008)(66946007)(31686004)(44832011)(6486002)(478600001)(316002)(5660300002)(6512007)(956004)(2906002)(2616005)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDhiU241L3Z1QkdONFZ3eG5lb25XNzAxeGhnaFU4NXFlNFZRTXh1Tk1wajQ3?=
 =?utf-8?B?Q2tqRjJ4SkY2WDJ6bWhVVkpTM0RaMnpRajg4ZUZrWjd1cDB1THU5Tm43L0VD?=
 =?utf-8?B?L1pFdVJpalB6eTRjWlV2TExVY3kvMU9YVGkrWFcyTDFoYnJTU3E1ZnJURFRN?=
 =?utf-8?B?VHpZWm80TkljQzQ0R1JPNFlRZitjSkc5VEQ1eHJpOXF6SUhnOHp4c2NsNi9F?=
 =?utf-8?B?UTZsWXM0RS9XOERONThjay9NNmFpM2tEYzJtU1BNc2lxOFBEWHFVMm95NUFh?=
 =?utf-8?B?ZStmUWZZZDBOblRORGpvck91YUE2aGZtV0NGNkRqdWRnejk2QUFxeWRoNGF1?=
 =?utf-8?B?Z0QxYjdHUWlkUS9QUXFBakx0R3dPTGhZUUNPSFJlcXVTem1rU1VOblhBdThk?=
 =?utf-8?B?VHBERmhqaUx1RlZvUXVwVmJ1SzREL3FtaEJYclVoMHpkcUNiZVVCREowaTJS?=
 =?utf-8?B?MkRmZSt6TXZiM2FJVStCcktFbG9QQ0dYVnJuOHIrNGxSQjAvbnE5U0JDOWFR?=
 =?utf-8?B?REpBd1VvTnBHZ3dYSVJ3bkdaSzFCYjhZS043R2NUeFZIRnBJMjRTclQrSnBi?=
 =?utf-8?B?WGhXb0EvczUzZGo2K2p1ZHN5SE9NTitJeTNJTW9SMnNHb3hFMnRHSTZ4M2dp?=
 =?utf-8?B?azNhM3c0aGhxR1FSeXFLMFozTm94ektldk9VMUVnM3cwRVVvbHE1ZmltSVFa?=
 =?utf-8?B?N2UxZ3h4UXdEVWxXWmVoaVlVeDFHSkJxNXlyUlloSzVIWjNnRUE5NnRrZExQ?=
 =?utf-8?B?OVVsWGV5M3RWbVgyVXZKRnZ3VkVJQXY5MGY0bkdVdGcvcFhJMjZ5VlloWGg0?=
 =?utf-8?B?QUUydWhtOC9zYy8zaTE0VW5ONDdyWlhmM093T0creVEvNFRDeXM4QnU0ZUtR?=
 =?utf-8?B?YXVJdjBrRFNBaFhESjZJa1RmMWFlZXJicktOSHFoL0V0MXFpb282dnV3MmZi?=
 =?utf-8?B?MmlpQVNhVHdFbzFTVTRHUlJmZ0N3alFQSS9aMDR6QlQ2MXB5OU5nWnJraEJG?=
 =?utf-8?B?WHFkekhFSm1oNzBrc1BKRFZjcmxNbzhjK2hnOXNzZEticytvenFMU2xrdU1w?=
 =?utf-8?B?eHdrYXZmbGlKeGk3OUMrTG1xd3dFemFEcGlpK2ltSGRrLzRLY2NaYmxORXJr?=
 =?utf-8?B?Mks0eHBCNGZ3N3dzck9CVGNuelBnTFRsVWdmd3NxNVdMc3Rua3NnQmN6dnpz?=
 =?utf-8?B?SUI2bU9Pem1sMC9jcFd2ZU9TMWc0eHI1UG9saERmZ0ZuUmhSQ2ZXei9pT0Vz?=
 =?utf-8?B?TzZjOUlvbU96eFRDSnh3QklSU3hleVFNUzhjaE93RXdITUtuSENGam9rRkgz?=
 =?utf-8?B?OG45VzB0UnpPMFVKL0prcFowT2M3UGczNWtIUkpZdldnSDVrVnEwdExkRlZv?=
 =?utf-8?B?NDdRSmJqbVlzaVJyNDVqakJ1NlBRNjkzS1V6RnhNTHl6RG9PWVJTSUxkazVC?=
 =?utf-8?B?VzF4dFVYMDhERjdNVEFGR2lScnE1ZHJmRVNuWHV3N1krblFzRUtKMEE3Uk11?=
 =?utf-8?B?UGs2OE50YkVJWTFxNGdWUDluSjVzREVLZVVpdFlndTBDVjgxcE1PbTJxKzJ4?=
 =?utf-8?B?SUpvcXp3UWU1MUk3YmtlT2taL1ZlQnRLM2xoMW45WE50SjJNZS83RHVGaXVs?=
 =?utf-8?B?M2pTOUk5NzVVQmlLMG1MQ0lGdmFaM2hoRDNzdCtSYTNoM1h5M1dQaTZySTRs?=
 =?utf-8?B?Mk4rREZKY3gyRDdYcmYwdW50RlNHTE9oSEEzbjQ0dElzM1EwR3pSRERjWUl6?=
 =?utf-8?Q?AvGra7Lpf9fPw17IOF/2pJAP61Ps9lbXjq5UjzD?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4e3a06-468e-4527-c438-08d93ca8026d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 15:50:54.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsTrRq62NmSmjgVzeXP+1duK/zM6N43HWBSMwTua5qm/LGmk9UwVtN5jso2W3iVxasYoXMNHdWu7y5c5zcLrhJLK7FHdc4rDkMNxWK6A27kTAoiyNrCK1YUHBv8qCE6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6796
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/1/21 11:46 AM, Dennis Dalessandro wrote:
> Hi Jason,
>
> These two small patches aren't realy fixing serious bugs. Maybe you want =
to
> wait for 5.15 content, but they are small and have fixes lines. Maybe OK
> for the RC, so wanted to get them out.
>
> ---
>
> Mike Marciniszyn (2):
>       IB/hfi1: Indicate DMA wait when txq is queued for wakeup
>       IB/hfi1: Adjust pkey entry in index 0
>
>
>  drivers/infiniband/hw/hfi1/init.c     |    7 +------
>  drivers/infiniband/hw/hfi1/ipoib_tx.c |    3 +++
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> --
> -Denny
> External recipient
^^^^^^^^^^^^^^^^^^^^ No clue how that got added. Looking into that right no=
w.


External recipient
