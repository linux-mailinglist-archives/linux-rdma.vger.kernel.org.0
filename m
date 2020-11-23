Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7A52C0E9C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 16:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbgKWPSI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 10:18:08 -0500
Received: from mail-dm6nam12on2114.outbound.protection.outlook.com ([40.107.243.114]:8160
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731162AbgKWPSH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 10:18:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SomMrIURgxR/8ZVJvzWH2mePotEqETQ0NABWToX7Zm9ft0NfduAVuveL/rGRE2CleQi2tWlOzyVszfEXCGCCnN9qhPrzsJEb+30jsXlnlsVaj/qQGhFsR2mFBTSlDLoy195b2fYV/yA0ocLJiNLO8aWi3TeWSEMwDOTYlQQMkmSKOo6AGHloYbKt9jlmgUG0YYi3xM34MFzMfC11zgxOE0dttyL1SHjkVLAelfpSCIdgl+UZlIBPia6VqoO8jrIwZZHGQyXoHyNNowl3/ojNn4VFTMUhOAlhYCndV8v9XArxihhaoKz5PFOl91s61hZFFg9q/0EeTdS6Q1QsziJtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7aCvJWP8oTe/p2RGpmA8n6qha+jo/ydzPYN+o9i3kE=;
 b=AeMNjEceGJexGAtuAHjhCVKfglBwwmvaPnVmGcEUvujMIdKll5nwc9KdEXfvQKtCy8jqAvfUo0oM244TDDlcoChD/e1bwixte3qpB4UGJxG4MsYjrsQnBIJcTF3dzMx5m1XqjZJ8xAeuDZuNNl6XecTxm4FBeUmJpVPFUTgoDDt9gAqDD8RWnL49XWf4wobYhm/jnVMj6y8V7uD2iNmIF+tmML57m4IPGwaO/GH8i7N7Rr9ooompFHuJXC8sj78QhkEMCfrR/1bCn7UBSlO9Swa4/VC95Ei8TlwYItVAoaOSSlw+Z12B3eW21y0eG9GI+1Btnxg4DAdHYgsd2xDOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CornelisNetworks.onmicrosoft.com;
 s=selector1-CornelisNetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7aCvJWP8oTe/p2RGpmA8n6qha+jo/ydzPYN+o9i3kE=;
 b=Ax+mSnezgaIXCEqwMiFCVPS7teR7717Srz4Eczx0DH5RQdBi3b6YkgLfqOBpwv+Gqr/x8Y04uFlWoO4S+C2pfqmVyDYGnT1mJ+0+plIuIXdI4viJlrZHkgg3vjGsl5T7JShReAW2kqwh2dY2XDhPypcYgkpy1PfxwIBlmqBRIEjNacE48xqlB/pHXR+hInaKgoWs1G+d8hHBN5Sivou/Q4DQ6s2NgmKhz+b1QXkP1cBan0Z1qCcx/qmCZW/CsVk+fxLgN+NqF2H7DcDaoGKEmYHXpD5wyqM+MhpCtrSsVT3cAhWXlaZfTHjXic2FKCO9xFwHE7NtsVLP3GEHmAycpw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from BYAPR01MB3816.prod.exchangelabs.com (2603:10b6:a02:88::20) by
 BYAPR01MB5365.prod.exchangelabs.com (2603:10b6:a03:11a::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.30; Mon, 23 Nov 2020 15:18:02 +0000
Received: from BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::c436:2a2e:75d9:ebc6]) by BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::c436:2a2e:75d9:ebc6%5]) with mapi id 15.20.3589.025; Mon, 23 Nov 2020
 15:18:01 +0000
Subject: Re: [PATCH] IB/qib: Use dma_set_mask_and_coherent to simplify code
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20201121095127.1335228-1-christophe.jaillet@wanadoo.fr>
From:   Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Message-ID: <eb1144c2-f54b-621f-0d7e-d6b8e3d47462@cornelisnetworks.com>
Date:   Mon, 23 Nov 2020 10:17:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201121095127.1335228-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [192.55.54.42]
X-ClientProxiedBy: MWHPR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:300:ed::21) To BYAPR01MB3816.prod.exchangelabs.com
 (2603:10b6:a02:88::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.55.54.42] (192.55.54.42) by MWHPR20CA0035.namprd20.prod.outlook.com (2603:10b6:300:ed::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Mon, 23 Nov 2020 15:17:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f85098-2638-4067-2781-08d88fc2f70c
X-MS-TrafficTypeDiagnostic: BYAPR01MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB536526C00159C2AA89583BA1F2FC0@BYAPR01MB5365.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9fewKFJk/KGUNwUKWpkPzl98PtRm18xNtvv5rOcgE7Ab1DTmm/l379ar3nmVMh4m0WVFwW6eMCYlsZjUAdkb5at7XFYd05lCpXcI+1QQn7yazCU9ZA/dR/q5LjfqkUxjm6cFgZcT+tFceYaG4JpOnOgZI4vHHTYnXNcuC25WBwm3GQdNJde8fKbuvS9G2r32QhJPKpFL7xAYdMl859LbfsJJlD9l5Ul5adLhq36q2prdlJW8mie7vNDRmpVDw3tUWCIDS+lDPHpVyGNv5ZzUMko6/sE+P3C4EFT6pPAlpTfeUlFthpGkSXEnhAqS5j57EnO/b5UskoN3wD6jK3IgkA/qXKe3Q3Dyue7Djtd9uY83X/GukowPEOrMP61DOCMD+ddGbeApCRxGZ6A7XqTJshBvC5prM0fl9/yYWauSy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3816.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(346002)(376002)(396003)(136003)(186003)(16526019)(26005)(31696002)(316002)(8676002)(2616005)(36756003)(2906002)(86362001)(5660300002)(478600001)(53546011)(956004)(6706004)(8936002)(66476007)(66556008)(66946007)(31686004)(52116002)(4744005)(6666004)(6486002)(16576012)(4326008)(44832011)(3940600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3SbUSPtn+eGRURaHDFDGW1HUR0x1aR1pg4bnCIt5Sds4XPN3+F4u98d9psfuXKXVWmvBEB1A6yXVEEZ4FxuOAa7OwbzbGEYgp5qaIfpkRoSVlhKqMB/0mZ6X1YnXuw3MT5HrnnX9NPsUW9cvawL/7tQjoHEXdtZleH5QPyGDhYMOxQerxhkAwEvlxtvPMNz+D/B8PJJ24H09gzdy2TZki54V1rk6wr/DhlHrATjDP2bQFDsKl5YvDE3QhxUQ5eq3bdpGuFwmEP48KJ7aiToryvdt9d6vc92s/HoK2KpMYGk6R8+mTVbxMYocb0BbmOF6+o9Lhnyb37S+DAlSi0vvkitxKOqYW+CQgFQIjcUeeYSeklJVWMlc1bdRpwqC81j3dMWljGSq/phPIncSuzkakXMRUzaqztKfbkAXKIWR9xfAaNARC05GMb/481GEuqed1EO6NR/CB21n4hAyJGvGwVGtoOmmkMAblsgu1MXWGrFLFfKr2AWoNBKYLkaD8WUhMHoWEl+3FmoBe2SVqZuvrTelcmzt2eglRE+5wXv6IOEOUY+hm7pYtMeGWndC1J+z4/cR4z6YNgtroHmY5ntnTYiT1oM87zjjZXEUUGSzlO+j+dvnISACnm62d8m53kYleMnJ5uj1lzY1BvuvX7kZvQ==
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f85098-2638-4067-2781-08d88fc2f70c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3816.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 15:18:01.3535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oICzIU8/enDgHlwkwd+XedY39DrKUvF+YfcKSwFrkOfMqTqNi8uJ6uPTSwilaPzPvNZVaX5VIENiSiUb8cAO52EmqGmXP6DRBXC1n9hwFGq9q1sY1PW1K3FXWKjCdW6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5365
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 11/21/2020 4:51 AM, Christophe JAILLET wrote:
> 'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
> an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks for the patch.

Looks ok to me.

Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

