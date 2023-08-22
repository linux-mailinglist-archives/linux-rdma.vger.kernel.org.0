Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DDF784EA3
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 04:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjHWCUE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 22:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHWCUA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 22:20:00 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 19:19:57 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA8A185
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 19:19:57 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-e5-64e5544f3fa4
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id F6.E2.10987.F4455E46; Wed, 23 Aug 2023 05:35:27 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=JMBbBOoxceO6nl7LyqkLYVgx5ZVQkZQk1lUXfm9JEDHNvzMV+N6JHln1MvtlxSbgA
          FO3EcSgmP66SJFANB7cYhLIbJpYVKvY2KOWLdYWhiC4aE1x+0kqvrY3dByDVwghFo
          s8MtE9YcO/bhkELVXIhahJNpUvf8qbFjy/zAlvaK4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=VJ6hKvtb3N7KOBJ8iaOxD20Thcs557QOU92TtvO+zmbtKZjiaam1XWR8OcUwD3/FU
          2t2knLLiOt0miLJYNfBoUzzkhmuxVXbPNk1s+ZmK2xDtiBSV59TW/BcGMgxtbSh7F
          PVV2OU50WgFfcFfwoVkDF5PcOUipAjTCbMESBicc8=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:07 +0500
Message-ID: <F6.E2.10987.F4455E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-rdma@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:20 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVyyUKGW9c/5GmKwecTahbPDvWyODB6fN4k
        F8AYxWWTkpqTWZZapG+XwJWxZN0FloLdzBVt/YtYGhgfM3UxcnJICJhInG/cwNjFyMUhJLCH
        SeLA6idsIA6LwGpmidaubawQzkNmiWMn5rGDtAgJNDNKHDqiCWLzClhLzNvczQxiMwvoSdyY
        OoUNIi4ocXLmExaIuLbEsoWvgWo4gGw1ia9dJSBhYQExiU/TloGNFBGQk/h7Zw2YzSagL7Hi
        azMjiM0ioCqx/PciNoi1UhIbr6xnm8DIPwvJtllIts1Csm0WwrYFjCyrGCWKK3MTgaGWbKKX
        nJ9bnFhSrJeXWqJXkL2JERiGp2s05XYwLr2UeIhRgINRiYf357onKUKsiWVAXYcYJTiYlUR4
        pb8/TBHiTUmsrEotyo8vKs1JLT7EKM3BoiTOayv0LFlIID2xJDU7NbUgtQgmy8TBKdXAmHZz
        gVfetRW7nYMkdTIuneAxPa8isSVI7E5fa+pzG3vhVRUrL37LOps2Jy1YIdrG4Nlc0b0xy7oS
        ORKMDVqOrhQMDF0yoc5Ua3vvhYkFFqGRaYffTF74bLHl4nxpjeibL7vOFL/8oTfXo/lEt9eS
        7Z3XvLX4n7CFLJ22raLZpnU+22OdLJ0zSizFGYmGWsxFxYkAV1RO8z8CAAA=
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

