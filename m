Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB5048762C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 12:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbiAGLFr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 06:05:47 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:40856 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346990AbiAGLFd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jan 2022 06:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641553529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qb9ZGaa+IuQYEHx0t9L+H/YOwtcInhXv70DD6LrgZ5w=;
        b=P3vSbVCkEyVuBr1qIqXkyy3NqX9e3te3efmA1o2/VUgml3oB9BoH0ZNfMlKLHscms/YCuz
        LdACPl+5XEsgtbyOXltdd8fz9NSrUWuWlUYJQGnehrsyRBVx/CRnc0jJ92oWsljoGYDbKp
        r3uFvQnqEwGiON19Y8DfE7/JQSZvOzA=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-YYAel14hNYWFfMcApejHig-1; Fri, 07 Jan 2022 12:05:28 +0100
X-MC-Unique: YYAel14hNYWFfMcApejHig-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvV1UC7s0DSAd1GCSmDKu7QVbs0aNwk6/tVHu4DW3/6WYMvaNEcB1l7P8+xXW2CXsMsMkww7jWzdhgeo5Qs4/Ar00sAWqh6ztY/OsGLujxHrILyboCbEYh1E63yZY5TUc/uXXnw0aknh6CMIFqzDz1Cat7+toVQdTHJ1Opp2D/biipt7MJRBUCkcbXaa11XvC/M60UF8doeVTsoBanIvJOMn4PsnaEfDtoZREzQG1IZ++MciZHMRFKOMhd2F/ewD6ryFz/QHjNppw96EI9x3Y0jTVX9SD8VcL4JOk5mwttjAq0cNNZioatSsE0UU50+zj8n/V4+FWS2br6hK0XxZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb9ZGaa+IuQYEHx0t9L+H/YOwtcInhXv70DD6LrgZ5w=;
 b=jGYyGQXXbvRSmlh4kRMZLpV8P8yljftk9WIH36u6SoJw4KmgWw4MtqJ23SkdcfXTNmV0m/J1D2QEXdTx/n9aeDWdYhVPVIEdmBC+7/PFeRq0nHBnsHMzH+0JL7gu9UToiGYuiL0Hv4vPDGWydVBqWQ6Lp9HbfdCX/aRnBICN1cQkCt82+xaeca5KYBxypuTnICFrUF9FdbT5wfi5HrWeDYQxbyeOILu4e2qCmuEkQKq9r7LNpTl4kOu1VBalYG8weF9pTRg5thG1D81Y0dBy6mtsWpb+FGDF2gpgVS4KNq8e9UCQC5vBcKXgFcJSvhLD5DHlBDsZVZG0hCGwPvlihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB6PR0402MB2855.eurprd04.prod.outlook.com (2603:10a6:4:98::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 11:05:26 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::3026:e391:ba46:ce5]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::3026:e391:ba46:ce5%4]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 11:05:26 +0000
Message-ID: <bb4df4e0-3998-b83e-79cf-5158446ca0d2@suse.com>
Date:   Fri, 7 Jan 2022 12:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
To:     linux-rdma@vger.kernel.org
Content-Language: en-US
Subject: [ANNOUNCE] rdma-core: new stable releases
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::16) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94de4cf2-4a4b-4e98-c653-08d9d1cd9b99
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2855:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2855EA3468471037D9AB7422BF4D9@DB6PR0402MB2855.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9suywvSdv281V5RXUa4cZ0fTyDk7UFRp5mwEPub5uD4c/rTJ2gyFLu1nQbOWI7RAdKxWkbYRQBJO199RJQRnYqgENZS46ovJIRbRnqr7+u23ilIRDMGNVkOd7Wzv/lGuVOilHklUgg7iP5Vrb8PxpSvEqbhaMj/brYHmd7ggAdwbkFeIp+v8AssR9m3j/KO36f0c1cFVJwoIgbL+oNHLaZOs/WcYPKim1ZUVjyZgjemeFugdA5AU43ej0K4O6HiokWOaUgnprVne7DU14wd+VXy7FE/2FV42sEwg12GdUaivwMQKZXxHZ4KGBxlibdg43yBPi8hMhCmb2X5KfYmCYVMChSSdnjTE6kmHxztd52R1ZSpw3JQC/S3ZLvg9M8RJkM1dPxHoAzrInoLUIRQXLI448gNZm+2eBhK9DvYa4i7m1ymrHDu4MZsQkLmM0afx3ndOYtj0FYQMkZEPnJXLIZ79bOrPr5WOtiv4NBZMtBOlNifCoUzYq/SUxOCAUv3NA2UGv7vn+zqG+/xfsRn4phU5QIHyXeNArZxB70T8FJ32gtdws5VN3wsMm5IMx37ntefvZFx4P53Uj3E+UwIIrAz+C7Srfq2lxsW0SptW/8fjn/EyNlXBQEe/73xy+jgozU/zVA5vBruP+9MSiCWG08CveWQhMqj3j+ASchLu/ianKhCRI1q/I/y71L2gN62q95pY2BXLMqFRXaiSL5WrcZqRrcmbDnHjvbX+8vCd/r/icVt9Ko0S2+qEAk4vorUngYr4nz8QYDnBd27O513XvAdCC0TpXtXJyZj1XqgDvxUsvs8AmW0UKUkpHrwsTp3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66946007)(86362001)(31686004)(6666004)(966005)(186003)(66556008)(30864003)(38100700002)(31696002)(316002)(83380400001)(5660300002)(36756003)(6506007)(6916009)(8676002)(8936002)(6512007)(508600001)(2906002)(2616005)(6486002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2lUSXFMRDlDREVYU3Nta2J2cTR3T0JwZ3FTZGVWR2ppTU13U2V3d0lXUVl4?=
 =?utf-8?B?bzk3bk5Hb3FoQi9tWDJFcWxSa0RLRWhuZy9sWFh2ekZQVndBSzNCQ3loNHhl?=
 =?utf-8?B?ZVY0MEtOUExTakwrSXBteGU0NUZXUHlRN0xhZG1SV3FZRVc2WGxKYUF4aVhU?=
 =?utf-8?B?MmlsdEx4V1hDVTBNZlVna1FBdjd6aDZwVkJOeVpBdWdSUDZ5eW5mWjhuMXhO?=
 =?utf-8?B?dGpnd2FCTUZFQTZjSGJ3c3d6U1VRNHF0K2ZQcFNKZ2lZcGR6OVVqWWZkaVl4?=
 =?utf-8?B?OFFZR0UzeFNNYVhsbytsS1puYnU4a3d1WVhwQzUvOEZaL3UvTVMxeHVWR2lt?=
 =?utf-8?B?dHlZcEs2OXNTK3R3TXpiS1ZoTGtEcGErWUdxblpoZ1VZVEJvVjd1SXpWNi8y?=
 =?utf-8?B?TytjT002ZEZDamlMbVFnNWZJUHhUNFptYUUyM0ZIVlpwRU1hUWFKMitBY1I5?=
 =?utf-8?B?YmtSOXNLK2ZiUHNPelNtdjY3UFh1RDh1clFkVTZUOG1uYlYxQkZuVWwvVVV1?=
 =?utf-8?B?ai91K2lIWHAyMVBiWmZ6UnZ0d2sxdFZib1dhR1BsblQra2kyS0FXU1JheHJn?=
 =?utf-8?B?U2tTT1VCTldpZWxzTE1DZHRuWVlqcng0K0sxWkRyckRWaXIxRHM2NnE1R0pq?=
 =?utf-8?B?ZHJBY0Nna09lRlkwKy9pWkdoUFl2SVFkT0NNQjU0NEZQbGJ6M2tiTk1MdmZk?=
 =?utf-8?B?RU5HaGVDM2dJdmFJUWlpWjJGYzd1L0EwQWJaTWVGaXpIbG5LOXdQY015OTFZ?=
 =?utf-8?B?UUJGN2FFNkxYYVFiZE96eE5UeHFIQ0lJaU8ybEVtSkQ5ZEdRb2JNMG5Nd2ZK?=
 =?utf-8?B?Z3N3TDVNYWJ2RlRRb0JxMVZQRTdqLzE5aGd2S1V4TFZ6TDdiZjU1bjFJcll4?=
 =?utf-8?B?R0IwREhSc2dDZkljcFF5TE5td3lTT0l1N2dEL1owa1JDUERlYXExTStYOGw3?=
 =?utf-8?B?QUpSL3NtY1AydTM1R0grTE5NVmJEZ3VFTnNwVVNMYzBHdlU2bFlGemlrNW43?=
 =?utf-8?B?STBKSUthZFNhUWFSWTMxdHRxWWo3bGh1eUVVUHgvZWkxeGZXSFdQQjNvd2tI?=
 =?utf-8?B?NVJLNS9DYTBuVXFMN0N1UmNoVnRyVzdqa1FHZDhkYXN6ek02YWE2Z0o1eU00?=
 =?utf-8?B?Mk9KS2ZRbmRyUS9pbWhPVTdpa1d3OHhjZ3ZiWkNuZjgzc0VZTU1oZE9YdTlC?=
 =?utf-8?B?RFRsUDMvK3pLQXJWUmtDSkZjNlFPK3BZZE9UMU1nbGY5NkNaWTZ3V1ZRKy9q?=
 =?utf-8?B?Rms5OVN2WWwrdHc4WC9LSTkzRlo3L2RnTXRocG05VGF2bVh0bzNOSzFlRHJv?=
 =?utf-8?B?N0o1WTAwUlkzYUtobWV4OXBGZWRRbm1XYW1XN05EYzVGamVsUlNLRGhvcWhN?=
 =?utf-8?B?SE9PMVg3UnZkYXVKQnl4QkU1MUVEL3IwMk9pU1F6RVdGdTF0L0poM2RvTlMy?=
 =?utf-8?B?ajBVT1JxRldpeDE2WkR3RTlxZzZ0ZXdrUkZlYnhzSXNMandDNElndnhyN2cx?=
 =?utf-8?B?RUNMSUJ0VmdLd2o2bnpMVzVYejVOejlQZ1VJY0Vza3VXdWFYSFJlRVN4RHBl?=
 =?utf-8?B?R2xGa2MvdmJibmVvWjcxK0ROTHBVNG9tdTlTbTZEUU52MWE0Z1lTS0I3YzB2?=
 =?utf-8?B?azZYRjNRY2lzMy9sQWNwc0tkSjR3cFdEWFpjSjBBbXpEWVBkc0c4aHE1Z25l?=
 =?utf-8?B?Y1lQZW5jSXRqZHdBT1BDanRlMk82Y0dIbHlRUUZLUXE3ZTQ1MmlsaklUcWpN?=
 =?utf-8?B?ZWRyc29HazFKbDAycWhWV1FPdVJBbEtudGZHT1hJb0NmYTBnaTJoM25QSXFP?=
 =?utf-8?B?bS9ma0ZxOW1zVnExN3VyVlpGeGkxckVQdGVTRW81NnVneEJicEIzN2xsb2U0?=
 =?utf-8?B?QUtPclZreFZTUGRIQlI3bmNFRUZaSmZaV25KQS9GOVhSWkt4bW53a09aUnp5?=
 =?utf-8?B?WnFVVk9yOHZEYm40MVNGN1pPTVkzYjNQOVNndG54U3BGSkROQW5RdFVXL2N4?=
 =?utf-8?B?SjJyTThOY1FMV0NlQTVBS1JRVndkZVZIR1ZhVytiMUp1T1NHQnVQbXNLblN1?=
 =?utf-8?B?SVRKeDdORGE5SStDbHV5ZldlTVI4aCtBbzRWRllxMC9XQXNlbVYxc0JBRnhZ?=
 =?utf-8?B?REpIaEdPWkt0djJDYmtDamxBQ0syblVhUEwrcGZ0Z2kwMnR4YXNkZmVFWDFa?=
 =?utf-8?B?MUF6T3oySkNXMnJDWGJ0MmlzN3FIYlE2eUVjdlJoUkxrRE05ZVRwL01MbnJI?=
 =?utf-8?B?RmpDdHAzMW43NmJWbGZjTVBYeFRRPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94de4cf2-4a4b-4e98-c653-08d9d1cd9b99
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 11:05:26.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InaM3wVYUX8+PMDouLQxJBxtaI6dJch78Cpn1NMkjm6ZkAenAF8AT46+6tfCpZQoLwyZ6lz8AcUgqRKCwvEHl4bxtRgf/6NGA+gcT84qW4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2855
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These version were tagged/released:
 * v18.12
 * v19.11
 * v20.11
 * v21.10
 * v22.11
 * v23.9
 * v24.9
 * v25.10
 * v26.8
 * v27.7
 * v28.7
 * v29.6
 * v30.6
 * v31.7
 * v32.5
 * v33.5
 * v34.4
 * v35.3
 * v36.3
 * v37.2
 * v38.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v18.12
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:47:54 2022 +0100

rdma-core-18.12:

Updates from version 18.10
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
   * iwpmd: Zero-initialize the remote addr info
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/kUcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBp6B/9ZaWJwkbbUGpd2srKM
GXya9ebHbbPHJKkkACQLk+V3Z0XvozDu9INNkgUhVf/BbEuDGABSKdZa6KoJb9gI
81faW/ifB5hX+e+hSh9PvOoVjWPck5ZOMl1hsWE2OB+H7Led28hPugFKLSDeH3NV
CvcAr6yk71yG8y5HBqaGWyjhPxFSTsokFfKo6OelyTFAljEEgF60ShKHZcMYLHFP
1SuNZCoQQh3gC+6kU/ps64cbjU6Uy8dkqWhVyFoiNBlb3TICzJSA1gavcxuGqSN/
YJiouqgJq3IkhoyA6YzlavdfTKhjHYxzPpDniO5uYCfLGHG23IAdvcnyNNKp+TE/
rSoj
=mSt9
-----END PGP SIGNATURE-----

tag v19.11
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:48:20 2022 +0100

rdma-core-19.11:

Updates from version 19.9
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
   * iwpmd: Zero-initialize the remote addr info
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/l4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZHJcB/9YyPz5zF4biO/NUuC0
ePsELm6Gnfb03wvb8xQENqRf3cL1uJMxH7IpmbvRaA0CqOeo9txppGI2BSLPdGFw
33tJdpbtQH1zOMEH5M8nvdcxNmt3NVL7iH2xJcW4eTzUeZSIiMsRmYf2hVxjSxVR
ZnZBPAKSyeoo3gyoI1KHKHSKlsImJssPrF1YuLOUzSEjPC6Fv5bFEDrosGb4Lg7k
rYwnAI0w0d4JDuVHAM5qj/3o1dEt98BIJKxDM+dRPWry1GNFU3U0fH0Fzv28QdKs
JtQPzp9tslBkcIn1kZyx5NrwnTN4x+yshIfaZwj6jr7NHFCsi5rZlpcXcE6VcAL7
OE99
=vGha
-----END PGP SIGNATURE-----

tag v20.11
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:48:49 2022 +0100

rdma-core-20.11:

Updates from version 20.9
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
   * iwpmd: Zero-initialize the remote addr info
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/n0cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZJQDCACsZfA3v4MGjIBtvWVe
XRe2gvwuHcA+A1jMPtLyJHtUlvA+oA8vZRqznse9A3ieyFNN5cIQtsdtlP6fHFMf
+OabWu60ArGl4Zh9iUAh/07Z65PcrDT1DDvpJILekV2/PkxZVKheRaRfT+z+qs8y
4Ij076znRykeF8e0ovyeHzjWNaEpz81K19h6NHIno+T2l4iSACs3BV+rLfD9A1c7
5LSWSA/mECc7SVlPNZcRvE+URhrN9p0rYFt8kTg6kjRTFfMxMmk9tjtnNVl1gXgY
keAmEstGg2iYZcnbg5nEej18pj1yQw/656XhAAtWQso3nSE7mbomz6UTk7ijpZ6M
3T0s
=Kt6N
-----END PGP SIGNATURE-----

tag v21.10
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:49:10 2022 +0100

rdma-core-21.10:

Updates from version 21.8
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
   * iwpmd: Zero-initialize the remote addr info
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/o4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZF1rCACX8cqufkwkH6dFGBRt
DRuTOW45c9MGaxtKQjuVX+KJ+g0ZKFWM1YZE7sN2Xae/0tS6akhcBVaM+N7qNkgr
ZVoLtQlnbzIcrZPxH3RjnPv8uBKIyaViEKbF9iLvDn+qgGW43KfIkPS8MixvvNEv
4pynqwnwJfKD0cbyxjRinhXZCvEI04908Tqj/8ofYqJByKtl2f7axKzCogTckiMD
wqnfuZeax4u7ULyo3KJ/fnh/zBaP0sXpVrxQ9iP7zcrNjPAOEFEfZ0tNunmW9GKV
rEn9V3utXSyMtx6rzM32afWLlcHUuK4uVrh6EoDBx/1m3IxMBFHraQimPOnBdm81
IGj5
=tazT
-----END PGP SIGNATURE-----

tag v22.11
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:49:37 2022 +0100

rdma-core-22.11:

Updates from version 22.9
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
   * iwpmd: Zero-initialize the remote addr info
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/qccHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDYZCACO6hVQgT67bbQ6jDtl
WFQRAflPGeChZDC5Qmm3Umkta5b8EDV1V69Ma9em3lkBysqG9wxyQYqKIvvQXAaB
dxpkPIy83WRmjWOGzXCEf/ck/Yv7x+csEr+WnIxyOblcvuMBq3m4nyB5m/XZf0b4
2ulnghSvSDr0EI/EiZXWuHec5ex/fjsfaNQ0kikeUvDyTO/i7tgjrsmsuJ/FIy+C
JmKIMASQoeDcTCYZ0hICc4z7frBFJ7Be5ybA8Stxf87iWkSJjM6txQw9ykBaStKc
m40UgNiwzWEXvyPH86WzpqnDO5/g1wEV+LNiPtQHsTXM4PfKQacB8m98tokfgHZO
pTXf
=a6Yw
-----END PGP SIGNATURE-----

tag v23.9
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:49:54 2022 +0100

rdma-core-23.9:

Updates from version 23.7
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
   * iwpmd: Zero-initialize the remote addr info
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/rwcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZCFRB/469f1jBexE8YPxhymv
yx6JRNy2rYS0Fi+yP058JogZUhN1XwbU2mX9NlNG4DB1rP6hcCpO6QYmZIkp00AP
+ai/GrKsd1lJrShVi0vDgIfaj9L4chArDubBeP1wj36gbixy3R1H9H+QgHtBMihK
oplDGlTuGBuTjZA+EpOBpcU+YWGIQeZEPSHAbNX+tVOD9Nh6M7EBzmmm98ue7WZM
ZlSRmKeEve1CSCxcyQ693nXuBpZQXuwjeH8WV0+s/MwgSYmqna+aGcL/HJHF+nu2
LiNirXV+X33Iqs15WYKAlBUE1P8Bs8QI2dnALvI137scb+qqF3jKmY055og0EXNq
Bgyl
=OjI7
-----END PGP SIGNATURE-----

tag v24.9
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:50:10 2022 +0100

rdma-core-24.9:

Updates from version 24.7
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/socHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDs4CADAOiz5s7AjErWzSjda
Ze4z7m3IOX9lr53gSlM/MjCq99zUIe7KUm7TgjjpkFNJOdoWK/ORPjyEc4gr4OJg
2Z1iphhoiUT4wszXkszVxUf1onga0BjzW1/37VwQNR6HOPIGau+4VKPG/7vMw2Rk
sRJSLGBXCQ6QYE0ruHP8twC/JG3ufkdfqwl9L/8sHMfcOROqqZGb1p2Q7bHMdsRH
GYe2Rk8Fab9OJiI/vcgpUOAhCfeGDPBKRwxc3FyhGaN/YYpz8vE3nB/w2wM4dXab
qSzwMJ6bfYj1aXMYF804UzCku6oZFlHMKkRDchtx2L8kEjsJjyu0cfFcetEY123k
7MHk
=JKCw
-----END PGP SIGNATURE-----

tag v25.10
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:50:34 2022 +0100

rdma-core-25.10:

Updates from version 25.8
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/uMcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBQuCACb3BARwTMWM3L8DBMD
WXYlVKGeQO2ntVenT/yXQ2Q5o9ZirlmhR5yNXcNW6B8Fm/yA7okl3LhxF5TPSHBj
QwwrDy+TYzocAR1UJl8DIPmeXcektXzY+l/soZy+bDWsZpnqhRLrB1+qqHFGmJ9Q
vt0Uqo5deUn9WS08h+lIhNZXJJ0RRdJCVXhfzS6f0K4SlgSEU7Iavk3sksXqml8i
X5qS5gHVK3PygIDX7glgeIhnHyOCyEiGgfsh58gV69Oxz/DpTEASu4WWlHloHsCt
8qgmtmbwg7ZVctGhEYI1xvdooJ4FgcmHPwzVt1bwSyoEIlb7A8xedveeDfvBHUun
lixu
=vc0A
-----END PGP SIGNATURE-----

tag v26.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:50:51 2022 +0100

rdma-core-26.8:

Updates from version 26.6
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/vQcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZKjfCADBsWbKQjgkESvAIKlD
LrBfOc4bmapsCen4EUGjjN3Upkq+c+ISG4pmLtmH/SyQYM4TxpkmVXMUpMKroWM1
hVlAdbyfgjrXcY/yjjQyfhg1m9jH8bZQ9fBlsaH2+sR9lGnYLmcuOHrrOda/U5/L
hWdl7QwhMupnkuEwlr0qylUhsXQxlwBZQqU0l1Zp01ki/59YdPj3M2gqOWXFKVuu
MGYw+71VMDlzgcHh067LgatM+7Rkgxq6FTLMB35hTWDuSokwmBnd1y3aYcQk7Rpt
Fuu9aqB+WZsa4I6f7vxCLZRBcRf7oHNhP1nNBizRtJczMatVMtYARVCfceAHRjAF
hWIY
=z0BX
-----END PGP SIGNATURE-----

tag v27.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:51:09 2022 +0100

rdma-core-27.7:

Updates from version 27.5
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * azp: Use ubuntu-latest as the vmImage
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/xAcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZLY4CACnaRRQxSEbmPbzlGOh
mqVU1mmMAsaD8TYlfxIGhKczYzZhwRT0TRBouZhA1QrMkxDZ+S06yapAXmwLqNUn
+OZYaPQVGLz1CvPzHeirh2Xs2bS3OfXdswU0HtD4e9dyL0pAVqH6gvlGE+rz3umb
yAuFnGjvASPq/OrWr8mq7pYdftJ9tRJ4hmoNTmLdXf17jJA2qLKlo12mS+Dc5/6C
MhCudb606kjMhTIlGXHsZz7r/cLlgU6uc1oFHz6cCUJFyGRiLKK/mQ5bNAKD7154
ptmN1pcizm4zFnZ9l66Hewes7hL2cBSJZU9bH5ffJPazXDwpthvicJgs6eD+mJWE
Sgbg
=ycsc
-----END PGP SIGNATURE-----

tag v28.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:51:35 2022 +0100

rdma-core-28.7:

Updates from version 28.5
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Initialize all fields of doorbells to zero
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/x8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZGlSB/9g/xCXaBY6wCKR+SIh
vcDP1IBR7Cq4XVXR3TNmW8Zo7+V+UwJRSZahaOAXR2QbNw4re57o4z6LlXBkSJUg
8BbGwrv/NeyK/YHoEuwp6iP0hX9ppcJqCKKh7dZTRKF2rc5SZLcTbpgX7CvbIyej
dXuUlolQXDjIcLvqBjVyxYZD03NHy5xPNC+mBqLicqvPH546XY1VzjLzLjR4O2LY
yAz/6erVV1wzWG/Z8t0HBZg8+Y1WerdT81C3jTWnufuT8O1jTQw4cM59jyS2k5Y/
ldny6IgiRa7aZQCScYZEBcekenamImYFWZce+/vAzUaMU12mcfz+/URG2XvEgZjq
CyIW
=nOcC
-----END PGP SIGNATURE-----

tag v29.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:51:51 2022 +0100

rdma-core-29.6:

Updates from version 29.4
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Move memory barrier to the same position
   * libhns: Remove unused macros
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/y8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZFNQCACxirEnGRlrAIhwsLa1
XQKLzPZlD7eNJBCLtUszOoWumJjMrSbvq9Gp/Emd6YFTxLUdAmCcRrCc/pYAEBdB
NN4vidyEhoP7oo8aRbX4Rqj+mwqGYWckWZx0r0sCz/DPT9pYEXjdevlY778/ELom
W+gTxbvmmoLIJSpBAqNV/P8BaxfgpPTFFcusgHQK3kl1MdCm4YqAThmOiX2qsbXj
A24EC8mqZP2k0ct9aRGaQIihcLy9XlmA87GNgBkBLKu2wtQgNIqbgvhnuWUIHXk2
ua5D/DYFjy1qi9gqr/eZXfi546eahJzWzk7elLydYBKFBJ4qTc6ZwT/boRMBECgL
Sr1s
=YVcg
-----END PGP SIGNATURE-----

tag v30.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:52:12 2022 +0100

rdma-core-30.6:

Updates from version 30.4
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * ibverbs: Fix missing copy for srq field in ibv_cmd_create_qp
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Remove unused macros
   * ibverbs: Don't memcpy padding in ibv_qp_init_attr
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/0IcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZNPVCACv9r/35i28rUY5ow0g
xhAib1WnaW/zhMJzznmXP6nYZnTBmU85cRBpt0qN26B7wnQmMczp/Z50l2JP9TU8
EeJgIUsTZUGtGCWsFoxg2HDMpY3y9R5iHsxu+xR9be2uNEbwlAfgGxW/BabNdrDc
1qlu7+E16IfHJXwkLcrn6h4WCA9cR1Aj5Wj4hmRYP5ZRd0xy7ADTxRSKUdM77Z5v
4MvmEiPGY46tjS9s0pf3z8ZyA9aiaBfSFuo/IT4oGwxNMyOk+Yhusraax2aXZpYI
xIVYcU8dF/a5FRSto6CrCAixfl7vL1T3u2bTI7vzq1+9ob+8xJQ+LkcMq0QexxW6
u/hx
=NChB
-----END PGP SIGNATURE-----

tag v31.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:52:29 2022 +0100

rdma-core-31.7:

Updates from version 31.5
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * ibverbs: Fix missing copy for srq field in ibv_cmd_create_qp
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Remove unused macros
   * ibverbs: Don't memcpy padding in ibv_qp_init_attr
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/1IcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZCJHB/43NEQNZN7/KA2bwYil
gU62grHt0snE/od15Gijzbf/N1nv6+UdEosvSRh7gjlSDqz0HKBxZh67OzQF7uVm
B+lViJ5tsrqlvCRn5ujqOnriWJKcZ9U2w5pIZhJU4k8athcTCi+lqfkurfdVsycz
BE/yh/YqrZ0zXuQmic+wJc8XuFubXYLCDqeCoP3CS9xrf6f4nvMDQIc4hSkhnQOv
NdJyBTLd2QgDVi+ylnbkCzDZJLloxNUheJXr1DFbFWyeW9oq7P7DgMrYKuNR1zzx
lnuAooLAMFryiiHZLedKBfQgwgo1XRYuwHy3XUkKSJfJxNtdXpAl2yrkoN/TW5eS
Ouuf
=/Lxc
-----END PGP SIGNATURE-----

tag v32.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:52:42 2022 +0100

rdma-core-32.5:

Updates from version 32.3
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libqedr: Verify the comp_mask before create qp
   * tests: Fix QP state verification
   * libhns: Fix the size setting error when copying CQE in clean cq()
   * ibverbs: Fix missing copy for srq field in ibv_cmd_create_qp
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Remove unused macros
   * ibverbs: Don't memcpy padding in ibv_qp_init_attr
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/2YcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZC6HB/wP5FVqvlhnCh62UGAu
F60qwW2q8iFcDsaA6tQOePgUGVwvD90aGQnpLCK/xChm0vfq4HwLZjotNybmkUEH
O0HSc8Peux5E5Lk5rFRsIWeAcGNKP2vgAiuztmknnmtm6EqByWAIpNchTIlfLVly
ysKWDcVI6PlYWarhjyWl6NwvuC2bgeXReZXqqBY3UoGD1GlYGNnCBkvnnaU9TtG8
EzUq9gX4vtXMtT39T5YcLEoXwHitUKuY92TpL9cvITeGK70+cBRPlxZM3oeVA3Qw
hsTpIyO2Yvmv0P8wLE7QZGKg9Cl+nvRxA6ef1JIp7Yqzr5oXPxDPJ9cHsDEdOTNG
fpTA
=ksBo
-----END PGP SIGNATURE-----

tag v33.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:53:02 2022 +0100

rdma-core-33.5:

Updates from version 33.3
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * util: Move BIT() definition to util.h
   * suse: fix CMake flags
   * libqedr: Verify the comp_mask before create qp
   * tests: Fix QP state verification
   * libhns: Fix the size setting error when copying CQE in clean cq()
   * ibverbs: Fix missing copy for srq field in ibv_cmd_create_qp
   * mlx5: DR, Add check for flex parser ID value
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Remove unused macros
   * ibverbs: Don't memcpy padding in ibv_qp_init_attr
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/3kcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZLFYCAC84ftdXi1CURDPekz2
/g5C0H1DYJ2+yJ8X2eVK6/YVF19n53h+I2SDFV5Z/nRZ1gNhdXYehYZd4whgJVSQ
I24FKR12zZ7AqHmNcc+/7alDv6WMgyznTJe/9JZS5tdWYZchk0pId4yXkuE03IpZ
EwHUEjPawKVs2C8AQjCXO0gMHlVEVbASxZUQ4qEB+JmZUvDZz/AWBR2P0Yb/R1+9
kk5RCljZJa9N64vi0JDPsOnaqLe7VEsRI9IVQRCd1Vw+3rQbRBG/DUCsHu2hj2vE
CBw+Wzj9Lqb57peVyGvJ/WxEsW15IdgexYrp5xTVNI7tK/oZNycSNkC7kjHV2hS0
rUZL
=6MgK
-----END PGP SIGNATURE-----

tag v34.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:53:25 2022 +0100

rdma-core-34.4:

Updates from version 34.2
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: hr ilog32() should be represented by a function instead of a macro
   * Add align and roundup_pow_of_two helpers
   * libhns: Forcibly rewrite the strong-order flag of WQE
   * suse: fix CMake flags
   * libqedr: Verify the comp_mask before create qp
   * tests: Fix QP state verification
   * libhns: Forcibly rewrite the inline flag of WQE
   * libhns: Fix the size setting error when copying CQE in clean cq()
   * ibverbs: Fix missing copy for srq field in ibv_cmd_create_qp
   * mlx5: DR, Add check for flex parser ID value
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Remove unused macros
   * ibverbs: Don't memcpy padding in ibv_qp_init_attr
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/4kcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZN7pB/4lp1wnf4ZHn5CN4a7I
33tuRmZ9dtzOFS1lrqC1r4uoKHwWFAZG9+aFseuTtQbN34x93IsuK5bcVPa1TmFV
bzdrxqYXJIn1x6YVm2170LIzMza9NOYT2urz13b3hrJeO1PJwR8O7vM/O5Y3jEcy
U0UeV9d7WHjxhghE+w9wx13zoRcnsztxOpxVzkKFk/JkbmE/bcMwcromjRFc0PFB
uWuN3Hd1VPJeDq12bK6o4+17Dz9NKM3rbe0ZjUlzasETYZHYTnOJodQmx/oApa7e
erL+pDLdISB+ZHMvO71Fvi57jPLeRs4uoUEeGPcjtbMTq9sttx3hK16BxoMEy3pl
JNj8
=8xn9
-----END PGP SIGNATURE-----

tag v35.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:53:44 2022 +0100

rdma-core-35.3:

Updates from version 35.1
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: Forcibly rewrite the strong-order flag of WQE
   * libhns: Fix the problem that XRC does not need to create RQ
   * libhns: Don't create RQ for a QP that associated with a SRQ
   * suse: fix CMake flags
   * libqedr: Verify the comp_mask before create qp
   * tests: Fix QP state verification
   * libhns: Forcibly rewrite the inline flag of WQE
   * libhns: Fix the size setting error when copying CQE in clean cq()
   * ibverbs: Fix missing copy for srq field in ibv_cmd_create_qp
   * mlx5: DR, Add check for flex parser ID value
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Remove unused macros
   * ibverbs: Don't memcpy padding in ibv_qp_init_attr
   * pyverbs: Add dependencies between Context and DrDomain
   * tests: Skip mlx5 flow tests if DevX general cmd is not supp
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/50cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZNUbB/wOZ5pmUipTohTwnL+n
tcV6PB1MngcV+t/T/wEz06riEq9q4dLSoxv9ridQF6uNEGoR8kkTH1nTNty6hh1C
6iUEwaycsfIVhlkifjTiizKHzJXabJwm+SaUlFY/tuLzDM2874m7iLmG+cyhIfvv
9+eY696WU6pNuB7U6QskeXtY6qWvc2mGZieqYCjIyTHhGFhveP4EZl2UROaQ5Fwt
Vqr+4HxoiYo6aLZs7Hv5SN2bkBEWpA1Ba9XwYNcqdKrIPKrVQnnuk4LyaHNskXG6
D+PL+KIYT/rsvQl9WycpgC3yhqasIy/R3H/9gCrxqPKPr0LqFy+dL9SglAgxeXxH
CiWf
=FZNT
-----END PGP SIGNATURE-----

tag v36.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Jan 7 09:54:19 2022 +0100

rdma-core-36.3:

Updates from version 36.1
 * Backport fixes:
   * buildlib: switch azure release pipeline to ubuntu-latest
   * libhns: Fix the calculation of QP/SRQ table size
   * libhns: Forcibly rewrite the strong-order flag of WQE
   * suse: fix CMake flags
   * libqedr: Verify the comp_mask before create qp
   * tests: Fix QP state verification
   * libhns: Forcibly rewrite the inline flag of WQE
   * libhns: Fix the problem that XRC does not need to create RQ
   * libhns: Fix the size setting error when copying CQE in clean cq()
   * ibverbs: Fix missing copy for srq field in ibv_cmd_create_qp
   * mlx5: DR, Add check for flex parser ID value
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Remove unused macros
   * ibverbs: Don't memcpy padding in ibv_qp_init_attr
   * pyverbs: Add dependencies between Context and DrDomain
   * tests: Skip mlx5 flow tests if DevX general cmd is not supp
   * mlx5: Fix inverted CRC seed for block signature
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHX/8gcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBj5CACHnOwEheFJ2oUhO++2
G86Mv4VmKCLLMUjlShLYrjlUx25dgESGnnLOlEV1X74UBXGnKGr6yGvEtIBVtwp1
tuEpYgfLJ24dvyJjCSFhgbIDgPJTUDyxdOgvMggI5aBSm8z26Jpj54cXdMcJIEi6
ILBT/n1britb67NbwAi3KhLSXTYiWCfDKb6B6mqdEMOlQBySE0qp40mJt+DqSzvr
wORMUroDmgPil8XI8CQoybVbnm4ugCJ6sg1mgeqE4PSggWxH6WBaX7OZZCPESqyB
xK6+I5flY2hLE8o27c3Qmv5BP8gZP485dmWl/sGIS8HOz+XncntzLIvQlC3IXGzg
zoIp
=5suT
-----END PGP SIGNATURE-----

tag v37.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jan 6 16:56:31 2022 +0100

rdma-core-37.2:

Updates from version 37.1
 * Backport fixes:
   * libhns: Fix the calculation of QP/SRQ table size
   * bnxt_re/lib: Fix the Send WQE size calulation for inline data
   * debian: Remove i40iw provider conffile
   * providers/irdma: Report correct WC errors
   * libhns: Forcibly rewrite the strong-order flag of WQE
   * suse: fix CMake flags
   * suse: drop libirdma-rdmav2 obsolete
   * libqedr: Verify the comp_mask before create qp
   * tests: Fix QP state verification
   * libhns: Forcibly rewrite the inline flag of WQE
   * libhns: Fix the problem that XRC does not need to create RQ
   * libhns: Fix the size setting error when copying CQE in clean cq()
   * ibverbs: Fix missing copy for srq field in ibv_cmd_create_qp
   * mlx5: Change pthread_yield to sched_yield
   * libhns: Fix wrong data type when writing doorbell
   * libhns: The content of the header file should be protected with #define
   * libhns: Remove unused macros
   * ibverbs: Don't memcpy padding in ibv_qp_init_attr
   * mlx5: DR, Allow to query devx_port without register_c attributes
   * mlx5: DR, Add check for flex parser ID value
   * pyverbs: Add dependencies between Context and DrDomain
   * tests: Skip mlx5 flow tests if DevX general cmd is not supp
   * mlx5: Always post SET_PSV WRs after block signature error
   * mlx5: Fix unexpected block signature errors
   * mlx5: Fix inverted CRC seed for block signature
   * verbs: enable query IBV_EVENT_WQ_FATAL event string
   * tests: Fixed DCS stream channel tests
   * mlx5: Fix incorrect mmo value in mlx5_qpc_opt_mask
   * mlx5: Fix subscribe event wrappers to get ibv_context correctly
   * mlx5: Allow DCS modify QP when max_log_num_errored is set
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHXES8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZATYB/4qdy5seKatHOpopf/c
vOL0cbNbn37+6Xz17OkB36Aip4V0IrmPZBFKm/sbyme7gUIu5qJVW0gm/mEXsbA0
akib2x9jIdOLISKY4gus1X6tgx/7cRaFqt9yYnDm3DU40i4iU16r/j3cwRgpNAy3
3xPHN4+EEnKpUHmMEDfD6SzVzI4N6D7HGuOuDe1V8AnGxuwbP3Pzp7d9NLsHDldF
R/zZWKmxlWyDXFl/uZ/Zv2yIVGaEFjCzs9F8DamNSgGsXwQYdUhYksaDdXC2wqrq
FS1Ii+Uep+BslfrTW/UkkpjMgbgtrRINpte4cMQ3TsC2mBfBYCltSwpDMV+WTUli
Wb2x
=a75e
-----END PGP SIGNATURE-----

tag v38.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jan 6 16:56:31 2022 +0100

rdma-core-38.1:

Updates from version 38.0
 * Backport fixes:
   * libhns: Fix the calculation of QP/SRQ table size
   * bnxt_re/lib: Fix the Send WQE size calulation for inline data
   * debian: Remove i40iw provider conffile
   * providers/irdma: Report correct WC errors
   * libhns: Forcibly rewrite the strong-order flag of WQE
   * suse: fix CMake flags
   * suse: drop libirdma-rdmav2 obsolete
   * libqedr: Verify the comp_mask before create qp
   * tests: Fix QP state verification
   * libhns: Forcibly rewrite the inline flag of WQE
   * libhns: Fix the problem that XRC does not need to create RQ
   * libhns: Fix the size setting error when copying CQE in clean cq()
   * ibverbs: Fix missing copy for srq field in ibv_cmd_create_qp
   * pyverbs: Fix Cython 3 code preparation
   * build: Fix python library location
   * ibdiags: fix small buffer
   * ABI Files
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmHXES8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZM/+B/wL/74twIdgZSNjv37S
VR0ciRMgIcLgAg6Tz7ZRlEFJWsk8Yqzq2u5FbSFte+q+eV1H+Jyd4gDzm8r53A2v
N/GJk5FrTJjxZ8WZmPhqaLta5agd1oTXlUki3P07IM5ujADpK+xbFT39xfsWBwGt
p46tNAsT8G1yR1Wzu7FMpPDeWSLOooAU7ggPCTOHiit+WBcXye/JZZyDeiKEq33a
phqsXOxIJSWWFhiafgk/LxtBslDfzH+PMIOs/W8ES2+rMLD250BcWLhGuFnHGqNr
xQqZzug37MFpSirXC48sB/Tw04D3qqNZYfLW5WCNUggJKxbkr52vLv8KsDAVcSGn
0Oal
=bokH
-----END PGP SIGNATURE-----

