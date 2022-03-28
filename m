Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48754E9730
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbiC1M7D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 08:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbiC1M7C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 08:59:02 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1015D672
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1648472236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mpkCrX5QOSTC5/lHeueduEbeJiffl7KXMIvj5Ov5OMA=;
        b=beqkfJTn30i5eRQ4gxP2Dpy/L2a5YyrqroQ8Lk5oVmKszouSf+p+YvYQ8QsBcBBrJjRrLr
        IhMJ89y3BVpJozkaQOdHc30iYC6N5qRizkd0Bdc7zgcxI+7VsbsbvobZ2Kj8Rm1H3tgOLL
        CE8YjqheDPK2Ai7MoEISsJPfW4PFnzc=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-H_9xnhjGMMSzFS_8IV7aKA-1; Mon, 28 Mar 2022 14:57:14 +0200
X-MC-Unique: H_9xnhjGMMSzFS_8IV7aKA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WixFmsFNHxBXJU4UowZ7l6Y52n0DlOhqhWzf3+4Z/k2RwcvgQu3IVqywop+DyAL/TPaXaE39zJa9osRTgYv4Gzgx1AEFrirgN6L9aDy7CZWZ6uvM4qEopLpoixftWPVy705HHILlTPR4yiKmL9syeG8hJQ9kaEY/XNZcC6OCU9WmPlDYonAU2y8PUaa94RGNH1QGuhmpMtSQLMKbB8sTPK0dKL2Tb6Dlm22y29772PZxmSxHv2flxO0TxQDS+jmcXvefgM/OCgcwfDewtglC+TiPHrsJ7zmSXkpoFbYjU/0jQkxuop4W4l2uTnwApRSST1ecua89h7j/KWRQj/gSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpkCrX5QOSTC5/lHeueduEbeJiffl7KXMIvj5Ov5OMA=;
 b=Iy2iOMMsoDBv8wKiWcXAXtusXb9p+FTwRs5i2N8YuR4idab1OUDKOYYglXllcwPlV9yH3C3Mm06Kn7c67J3eVZmrb3Z73x0izOcuTMSe1i8ktKzfBlk0hq/EY73OLNQ014sSagy7v507G3rFRjOz9SJoICuRddvbO/jdocu4O8/pbO/m+ABr9dztYl1U63ztK2oWUulEVi3+K5sudp8vcw55Uy79k4oeE71Sa1WpO7/zNw9nnZIqP9ahUGptgipMuIzK4TR9f/FIzJQbUMQwV05b/EoZIu/D3b9CKBeuibdlccJGypnJCVbPL7yvOpSRduBVGIfBS0hV5LaRfYJAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by AS8PR04MB8369.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 12:57:13 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::744e:de45:69f1:6fe5]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::744e:de45:69f1:6fe5%9]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 12:57:13 +0000
Message-ID: <8bcea299-3a07-d94f-c5e2-9bf3dc79207a@suse.com>
Date:   Mon, 28 Mar 2022 14:57:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases / dropped stable branches
To:     linux-rdma@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0168.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::23) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f1f561-a38a-4ef7-0089-08da10ba7a63
X-MS-TrafficTypeDiagnostic: AS8PR04MB8369:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB83695B783298BEF3F719DC5CBF1D9@AS8PR04MB8369.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOLWU3mm4HS+d0DSDHfwsUBdMLrIOD2TZkiE+kkypjDX4ILpvtr/qcENj9a6vPNJRlX5NCeOJTeNND9xEuMu3bxs/aZ+gmwEgphBg6jR099T1uRR7mBtYlGtjq18WKZ/2wbm4xwIArYREmD1VlnsW4xwsbrxp8Wag+eTmgVIxSh1YXUe40awXzoEo9Xo0jtpZroU52zpBKyYUqi5BLNIwVPSBdttd2ZcusSg9//+543JS9UktYaVMl/yvsOTQVNj+X2GBygX5BqCT2hly4pGB6vlypGkbSE07DSBvxsEjQTZMIpCIGy6aaNWgDfaTmpJTPxmfw/FTKcKz4swgS9U5/rshwJ62GdWnfE1gAwr1XsXOxO6O/Q9DhSnEJTZIllzoyUnx9PxDG26gzCMKADUJLomPmQyGYtE92a+r+AOrdLHrzzVMr6961RMrHdxTj4R3L44qbCPrlrXGsG7J/1ayDem4zcXidMDzylf64Evz3XJIEX2/T8qUXmKgDsnfHdioECW7IAE4DNvStTRJPJgoyFM2i3oCmdgLsJ87MWrp5OcsAjW6HhC4IZfQy2/kC2JMW9FbY2SOhx7NfYnmijsjo8mA9PwiclyxAk+P2wh00znI634KIDdpsCgmeoRoMWZjqeQYWabtWT8l+OXmW34xYX74cHXaSPGwvbhxLjG+Ol96/arHx1Kmhs+4VqL0wNjXmnBwF4vghtZxv9FQuTJDqJYog/LYd0pRJ9/fy2iy0llH6mLDwd7bfP3PBrO4ak5h8EL+Hx91MbQ/ip4JbOm7FbExgI3i9ZTRWzvmknculPb967lxxDHnLvtP6zL7e+y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(26005)(8936002)(6486002)(30864003)(86362001)(31696002)(2906002)(966005)(8676002)(316002)(66556008)(6916009)(66476007)(2616005)(66946007)(186003)(31686004)(36756003)(5660300002)(6506007)(6512007)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHJObmJyUXl0YlB5RVorOXJTOWxxYVdoNE1CZTliekZJYndRSEZNdldDWU9s?=
 =?utf-8?B?ZmxzSWpDdGV5cGplMHhOSE92blZPSWZJdU53ay9XcDBFTFRYVWV2SW9XZFF2?=
 =?utf-8?B?RXBjUmpDRjk5NTNXSjFydXdoZld0MFF0c0RnaWN2aENQU1hIdnBYY0hJR1Nk?=
 =?utf-8?B?NjRtRE9XZm5GYzJVbDZydE1QYWNCTHk0cFFiN29yTk5wOEN1MittN0x5UDNj?=
 =?utf-8?B?WEd3dFN3YzZkZGI1YkpXRGVtU0I5a2ZFQlp6T011TkJYRzF2dktuOEFmNFVz?=
 =?utf-8?B?M0VRcEFSL3JQeXphVWNUUStTWk5HcjBNUkhMV1RsMzBzTWNYQnNJNVN6ZEVF?=
 =?utf-8?B?Wkhoa1BZUjNnU2hYQ01aM2hXRlhZcGVsYmVYM1docGpZS0tBWGp2YnhYcElp?=
 =?utf-8?B?RW5DUjhlTUVSdEdTUU1aR2RlV1NmNW8wU1I5NkthalRWVXV2T2dYc2lyY0hB?=
 =?utf-8?B?N3I3bjk2bGRDNGlDNmMzYmJBSEQra3VpNW9FdE1xK3VkbzkxdjhQeGY2VlVX?=
 =?utf-8?B?akVFWmRNNUxHSHJqeXRxZ2xxM1o2U0R6TjZEekJWQ3dYd3dSeW52U1QwbFRu?=
 =?utf-8?B?VkUzZXB3SUlqY2RtMkdqQWpsT09HaDBNNnQ3VTArd3Z1ZFVMSTViMDRUUS9o?=
 =?utf-8?B?Q0p3VkU5NXlmUTZTOE4rSmdrTEtQUHNVdGRrcldWLzBPU0FYVWMwVFlucFlL?=
 =?utf-8?B?TVVOOU9zMG1yL3FtSWNGMjlPQjd0ZG9JVDU5bWdrNFBwV3FNMm95RERUekZ6?=
 =?utf-8?B?Ym1ySW1MVTBaUStaQXRKMUpQeUFJdzdQaVdCOHpkYVhmT2JndGh6dlR6SGNm?=
 =?utf-8?B?ZFY4RmVaRDV1TEJGZDRaZmZ4dHZzREk0T01NNU9hYlJhdnJSSGVaV0psUlJm?=
 =?utf-8?B?RkZPUTlha0pPTW00eEJLd1luRnptUFVRcHVueHZucFFsQnczbVZvZXF3elRD?=
 =?utf-8?B?OGNwSFBBTUc2RlFUcnJEdVV5b0cxTVVWTjRad3RBMlFabUdlWVB6WUYzZUxo?=
 =?utf-8?B?Yi9IWkh0SWJldnFzL25rcTFlNEZUcm44aWpJdXNlS3kvbEdJZFdsRzJJSDFL?=
 =?utf-8?B?Q3l4MmxBaStRYjVJQjN1L3AzZ2ZFVnoyQ0trM0Ixc1BLK1VaZkJUQklSSzBF?=
 =?utf-8?B?VVVHNWRtKzNRMWw3T0pWVXlqS25BQldVNWNKcXhYM3VLVVQ0aEcxYThRWVhC?=
 =?utf-8?B?enNVVDQ0VCtGeUxNT3V6eG9VNE1BY2lOQnY4MTY5MWVGenl3RFRhc0tQTUF6?=
 =?utf-8?B?UVZINlhTQ2hzWU1FTWoramZzTDJxRXRVbUQxM05HdU4vcUY5dW9xYURWemM5?=
 =?utf-8?B?bDdFWEMvNjVBdEdDWGRmMjhCN2Y5djBpUG82RFlTYmtEUnE0ZGo4Uk1ZU0M2?=
 =?utf-8?B?THhodDFtNVo1ekF5UWg5VHFJZHJjeGhoS29mNHdBZnk1Nkd6L2hlRXg5SDBJ?=
 =?utf-8?B?a0xSNHZPWm9CNWM1T3NndWF1TlNOeW1hUjF2V2FjSkl6Yk1BRFNZZ2lpRTk3?=
 =?utf-8?B?L0dhUHhIcTJacldSejFVaUdoSHpGd1FiSVVZZGNsVWlmTFMrTlZVNys5RlF4?=
 =?utf-8?B?RFpsTEM5Q2tBTDQ2QVdKM0oxOTE4SHpZYkF3Wi9RaVBLSE1mN2JlM1BBWllT?=
 =?utf-8?B?TGdQaGU2cHFta0FOMUFtbVhuL2MxRkxyWVNscmdrM1Z2cE9kdTBJL2ZReUtv?=
 =?utf-8?B?elpSdGEremtNUW5kZ05VbUk2eHBIeU5sUzFwR3pjWjNjOFQxWUZRdGg0TExC?=
 =?utf-8?B?Umg3V3VWTDlMUVhVOVMwQ2NiYkdIQlUxZDh3U2dwbHdPbk5Xa29oK0hud1BL?=
 =?utf-8?B?K1h3SjJFRVRPUC9sL0loVGdXa3FMNjJZWHY0MzlnYmJuUk43YVJmSHFzQ2J1?=
 =?utf-8?B?YTc3RUxZWHBPNHVJeG5rTFpOdVI1cm1aUEJaOVVlcE5xR25QWGl6U0E4US9F?=
 =?utf-8?B?eFc0dUFSNTdpTUlkRGY0cTE1MmEweEhUQ0hvWWpJaTNkQ29YTGx4V2NTUmhU?=
 =?utf-8?B?K0VTSG1oSmxhRll0dUVLNjhuUUpZQ2kzbytHUk5zbCtsYWpnTmZLVDdNaWVL?=
 =?utf-8?B?aEpqWnFFUVdHVFAvL0JIRENsSDhTdmFHbWNDY0JSRTVSeVNid2dnVWlCanE0?=
 =?utf-8?B?YWNCY2Z5d3I4d3Jiay9HKzZLbDk5dG9sT0xmbFNHdUdsa05Fd2tjMVFoSWJt?=
 =?utf-8?B?QlplZEJkcE90NTdXYVp6SjRVVU1HdTMyZmgrV1FoYU5oa2RyL3JMU052OE5W?=
 =?utf-8?B?c29VWmoxSVdJMTlGTzhBUnRmZlRVU1I4bXd0V1hvM1RjR3RlbTVKNW5IUVoz?=
 =?utf-8?B?aVhSa0RpZE9tQ24vZVFQSDVXTGxKUE56T2l1SmdicFZoZU5VNU5tYmMwaTY3?=
 =?utf-8?Q?Dj3+gTM2wc20+7qI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f1f561-a38a-4ef7-0089-08da10ba7a63
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 12:57:13.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1CHgBJqz6OYvNYtYk8EFZIzsPdvPqZRD3k1yajejbC85cyG/pUI9SAnZ8FASrvTO2IpOCS6/c42Z6+5VIM+XAOjHXNraDo06HmGnZi+/MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8369
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These version were tagged/released:
 * v32.6
 * v33.6
 * v34.5
 * v35.4
 * v36.4
 * v37.3
 * v38.2
 * v39.1

These stable branches were dropped (tags are still present) and will not be maintained any more:
- stable-v18
- stable-v19

It's available at the normal places:


git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v32.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Mar 28 10:12:54 2022 +0200

rdma-core-32.6:

Updates from version 32.5
 * Backport fixes:
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
   * libhns: Fix out-of-bounds write when filling inline data into extended sge space
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmJBbgkcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDuHB/97a3PYVXyD+5HLXolO
N9ZVT9AFcU1zMoSgfC+VhSiZgFnJx6Nn8Fv8Yw+0kKF+ml0maw7svCzBuhqDBqXa
bigM0L2MTxZUw10pmEn0lOtF6DvmrpzsgyTO56Szn1Ekk8mxfYp0ohSWXdIGOrvT
QZmMzx37gWgpDBgVM77vS5cYZIMo3AngYYD+9mT1PoRmhp7qZppMuyRPudBdc9eJ
cYsxKBnFciDq7VDJI58YYapQiSlEMCxYya4yVsDIVuus7F9eSfCPTqXALkVSFeh3
XvMsA6AiEl4ZiuQlA5Im6gYiy9d/r/Uleav0XO4MzTVS2qOLIXNiMCQ4ishkw1Ej
qi9d
=eJzY
-----END PGP SIGNATURE-----

tag v33.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Mar 28 10:13:05 2022 +0200

rdma-core-33.6:

Updates from version 33.5
 * Backport fixes:
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
   * libhns: Fix wrong HIP08 version macro
   * libhns: Fix out-of-bounds write when filling inline data into extended sge space
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmJBbhMcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZMX5B/9cF7Lrfy8y+GrMoBsM
gcuqtFmBx/stsOJBYaL41B1b6R/mE/F85j+N2LcvZ48oPpy4T2oXgSqwmAI23FTB
5a5D2bbi9umaoIlHRpy0A6jtKNhAMBXts8qXWsVJ47GOQCEvaB06JaQIPCwx5Mar
dEyGa0bcrhRUoEDgRL72eHOPM3pcoOzH9vhIDLDmsUiR0CkqIiEuo8l3L6vFR1T6
thWGJKKmQyeL4tFysIaUyp+s0IhZMEAF6Udqx3z4VJMFa3+ifyaJc+hKXEDBo92C
pvMQBBgMWfDMyqi0dvba6tv59FVBXnJfYUz+9AwEmuUcHgHOL4eFx9c8AN2kVmm/
ZTcT
=/5Lb
-----END PGP SIGNATURE-----

tag v34.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Mar 28 10:13:11 2022 +0200

rdma-core-34.5:

Updates from version 34.4
 * Backport fixes:
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * providers/rxe: Replace '%' with '&' in check_qp_queue_full()
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
   * libhns: Fix wrong HIP08 version macro
   * libhns: Fix out-of-bounds write when filling inline data into extended sge space
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmJBbhkcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZGYmCACNgUrM5ZSHa19+1G5Y
nnY1Xq9ZUGgdPzKdY9G6ObzKuTA/LdiQNwCSIYyE7KzsOGL+LTmzAw26yloAdTET
3N2b5cjbSDBGGJnVYQafmFyYhOUxu6KM8R9wUPCpFHGrT9xFFWQCNnriA1vfRjze
w0JvlvqVlkEMcLzS1/s4akkO5u3j9qq9mVUkUJKGmad9Nu4m/R5axTHCA+mdjZ/U
9BlgCh2IPePHDJbwW/814PW9jInyC/r0RBYDzKloXz9M+MZmxwU2luCmM874Hsli
0V4hVyphJT6/BP+iALFAYuu+8WxODiZY2KxFKg6+B+7eQZJMiSjvZ6hLj4zTZiWR
Rqbg
=M4GT
-----END PGP SIGNATURE-----

tag v35.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Mar 28 10:13:25 2022 +0200

rdma-core-35.4:

Updates from version 35.3
 * Backport fixes:
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * mlx5: DR, Fix handling of different actions on the same STE in STEv1
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * providers/rxe: Replace '%' with '&' in check_qp_queue_full()
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
   * libhns: Fix wrong HIP08 version macro
   * libhns: Fix out-of-bounds write when filling inline data into extended sge space
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmJBbiUcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZFplB/9Psrdh1cXETEF6Tmxx
Sl9RsVz7BOAf7LNgQBqoPcxaS3pTG6tp7NpYh2tCA5xJKePARBQ7B9Bipz0Bl/6S
mhFYKjAMSOWji/T50f6jbROjLdCE9wYWBOlQsG2SlUWx1LKix1MOCk8xeASbc1QH
P+tOgNcRpTpqxeUhb2QMiUhFFxp/aTWynlnxYApDK/SQNiUimNtDPHkE2aKGYNk5
KmPpAiqEWqzNc+9Rnp+Eu2ucdSFatCAPj9wOm9JxcOa+SDqhlUnStJBf+0fbCy1W
VSHOYp+fQsAsBdRUbjJU3DKKKu2l33pEzdah0h0mHIeiQ4znk2T/bPgSmYQBbUuh
1IdO
=Zj3s
-----END PGP SIGNATURE-----

tag v36.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Mar 28 10:13:26 2022 +0200

rdma-core-36.4:

Updates from version 36.3
 * Backport fixes:
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * mlx5: DR, Fix handling of different actions on the same STE in STEv1
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * mlx5: DR, Fix SW steering dump tool dr_match_param structs
   * providers/rxe: Replace '%' with '&' in check_qp_queue_full()
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
   * libhns: Fix wrong HIP08 version macro
   * libhns: Fix out-of-bounds write when filling inline data into extended sge space
   * bnxt_re/lib: Check pointer validity while freeing queue pointers
   * mlx5: Initialize wr_data when post a work request
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmJBbiYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBeVB/9oyyyRsKBBpr4io1+v
nJdrkhJ89WGNz+GC9auWfHCF7MAJJMk+g5ALt3T/tpE0naT7tyzMvhgJFpf3HSnB
8UQ/nEPlRo5tXYDNeHG8o+ZRL1OkK8U6mVE+IlPoNnqkRPZhaSIpbEnRU4oXwrlP
YsEfP1+9UXSb+rqHm/IaqsUwrKrsC//2bYiq8SF9i61MYTbBS6hDtd4pzyxaL5Tu
fy+ojGvlIAhZKTqBOtL2CpnSgrDmOYlRYUVNUrGinuagv2kspfJj+wOGeKns6p4t
+YBgCbnH1yGKwDFKyf2aKK5Cp43YXLHKiB82hDv2JIo1IMwEx2d0V0gdidlbTH9j
h+kU
=k0Iv
-----END PGP SIGNATURE-----

tag v37.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Mar 28 10:13:27 2022 +0200

rdma-core-37.3:

Updates from version 37.2
 * Backport fixes:
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * mlx5: DR, Fix handling of different actions on the same STE in STEv1
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * mlx5: DR, Fix SW steering dump tool dr_match_param structs
   * providers: Move input validation for memory window bind to core
   * providers/rxe: Replace '%' with '&' in check_qp_queue_full()
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
   * libhns: Fix wrong HIP08 version macro
   * libhns: Fix out-of-bounds write when filling inline data into extended sge space
   * bnxt_re/lib: Check pointer validity while freeing queue pointers
   * mlx5: Initialize wr_data when post a work request
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmJBbiccHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBkBB/oCDhh3/ffnJ3ObF4yv
LQFC0GyZHrsFP/ZuVyaDFw4vDQkM3Olh8m7xDJf+BiioVuoaIgtdQ8GfBHz3VX6F
eHgLVGdGdeuxYwvYodLd9OGjjrDWit6m/JeKtzOLp1StZR+JOhpNmOBL7cOhqZnk
myBfXXFQkvjkUMRDoGakVT4IbthDr+GmYq8WHsZ/Z4nx6py4qa9JxcZDh2iYaN36
mehg+BFNm42J2J3VVInc30xEt7utjmJgvkLbzPPajEIcUF18PCOBJnaW77vqAa+9
LdtKZkJnjg/pXiHIOtpIx/Q/MU5iQZC6QPVcGWRHBLYIUN0eu9KL7b0PdZkiy2Xj
gTKd
=8Qvt
-----END PGP SIGNATURE-----

tag v38.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Mar 28 10:13:28 2022 +0200

rdma-core-38.2:

Updates from version 38.1
 * Backport fixes:
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * mlx5: DR, Fix handling of different actions on the same STE in STEv1
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * mlx5: DR, Fix SW steering dump tool dr_match_param structs
   * providers: Move input validation for memory window bind to core
   * providers/rxe: Replace '%' with '&' in check_qp_queue_full()
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
   * libhns: Fix wrong HIP08 version macro
   * libhns: Fix out-of-bounds write when filling inline data into extended sge space
   * bnxt_re/lib: Check pointer validity while freeing queue pointers
   * mlx5: Initialize wr_data when post a work request
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmJBbigcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBWzB/9bYSksrJRJBKoJE4mM
WElO9ZY7LmvqTzy2g5lbv1esfEdX+js/vKZwwKQtXdB2BUZIboo1KDPJW0z50RoN
ZnW2bq3jHHhtrxCbUbb8/P0PgZ0FBf7QBkIIdyr/rWCsBj68mkO2KtTc3Irc2I0N
DSgbqTCEImTZPouFADt66xiu1ZHCnZXGhUptFf8pAQusBYh38Ob/B7t0+1U05RWK
VzhLzR8u5Xx2diUpwJOmlNCqAVpphu/5xUkwG35tEZFFKfKgr7E1KEHrAMUhKAkw
mtX2YNnlm10jVZhl1PyCZJRZVp308uAplryh9gZ5St1BQU0DEdvaUdcOv6SjxVUj
xlJJ
=nY5/
-----END PGP SIGNATURE-----

tag v39.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Mar 28 10:13:28 2022 +0200

rdma-core-39.1:

Updates from version 39.0
 * Backport fixes:
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * mlx5: DR, Fix handling of different actions on the same STE in STEv1
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * mlx5: DR, Fix SW steering dump tool dr_match_param structs
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmJBbigcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZKWJB/4z69OR1il0FKpviB3f
gnIGyF5yz3BWYRhIfJlqRi+0LmD53z7M+JF9PHgQ+U2H2aHijpvOGJdPPcRb55nO
SQr4f/PKaBVMOwG/y0QlSQRFM9eoBa978CcvzzMg8YfTh54fH+rBIheY+sgfvaZK
j5J2sKtSi8wjfL4SP/7hyzCHa7bskeVU+C2GFWjT9XippvHIk5hLjOu7F8l5FSUY
iP5aQVcEhsSCdyYeDL9/kguvm8MmByffTwppe6R1awFk+wkOWvbthEfzjY5L23Kd
COzwBKzhH+zFbNF5hTWkb+5MNf5WLFx+gTK6BmrUjejkzu67E+orMilwvKnHosDR
UBNY
=1MIL
-----END PGP SIGNATURE-----

