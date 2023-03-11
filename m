Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7416B5B98
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Mar 2023 13:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCKMY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Mar 2023 07:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCKMYx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 11 Mar 2023 07:24:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ED61220BA
        for <linux-rdma@vger.kernel.org>; Sat, 11 Mar 2023 04:24:43 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x3so31050347edb.10
        for <linux-rdma@vger.kernel.org>; Sat, 11 Mar 2023 04:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678537481;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mM4D/H21YxqRWkmTnoD2+rbp+XKo+/P1KeNC9uoVsMU=;
        b=jVrIE37aJBIFUhwyWZ3BfLlD8oJchWWytD5SDPToiH+XOw0EK9vnjxZiFfbPQOOfL8
         2VvKiuCh6oX5aC3ocdWFhF+AuLZpnvjnYw7Q5zkWZ2lzRYab58PFLEBLdXyRETLLn6nH
         zpYuI3KSL8s5oTS55bml1FvsD3jKzjLvwPj282WQZpWqXpPAQWQJd3Ka3NEJfpNTXirE
         W342yk5WCc8ZIfG+/Tk2I3jGGE1uxbtJ5P4aCtW/4/KuZFTsZkvxAG0vqwPLTPEQszmG
         DaD9P4iftd69FZaJ+YponxQ7SKKzdb9sOzG3VYja5dFVQHdJyUCTSPILs660wdMxe3SA
         2cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678537481;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mM4D/H21YxqRWkmTnoD2+rbp+XKo+/P1KeNC9uoVsMU=;
        b=3SRhhMFzVwn1drIUW9/SSqy645/MeRvZGGnNm2pRZ/RlixDjLnJIBjjF7TJt6pwWpW
         oeCIt7Lxp4JqJQ4lwDCO76S4Nuq7WN09xRVDbbTUcgDWJYRR2P2f4mgAKHsfutS/3o10
         E5Uo/pSVFhSPJ8Pl9l8WNxY/mrpU6dyYgOx8aRIc4/A7KIM3T5RBum5U+7fFF4MjbokO
         9nJP/mv4GNHLnzAFQu92ZUIPRKW48lKskcF8h6oCutGzoMh56NZe7lzk1IXLjQQzGYDr
         VYpAYPD/4ng+YHHfkJc+rn3BUFZn/Hc4XGAyumGyYt46Lo2nrDieo0bHN2ZAe70iVDKw
         +1UQ==
X-Gm-Message-State: AO0yUKXbt97GuaIE2EG8UxsUHARkh35JEIhcJeZIl+o/PZ1Yp0q4d96U
        xrRUbvDS6SneiQ0B4JONQ4hNetGnrDs1gmL1vys=
X-Google-Smtp-Source: AK7set9RYy6nHfB25XTqtzarTBtIgFwf+bhPe9vNusOukRzxpblNxPqmNt9NHatlSSwxmiC/wvFC07v0HjI+0OIwVqs=
X-Received: by 2002:a50:d543:0:b0:4af:6e08:30c with SMTP id
 f3-20020a50d543000000b004af6e08030cmr2810891edj.4.1678537481679; Sat, 11 Mar
 2023 04:24:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:640c:2907:b0:1a5:721b:4611 with HTTP; Sat, 11 Mar 2023
 04:24:41 -0800 (PST)
Reply-To: fiona.hill.2023@outlook.com
From:   FIONA HILL <barr.xaviergbesse.tg@gmail.com>
Date:   Sat, 11 Mar 2023 04:24:41 -0800
Message-ID: <CADK-NB3p==sKjWKghgSeMJ9FcmG-NfjAJM6xMjvoV=zYEeh9dQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7682]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barr.xaviergbesse.tg[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fiona.hill.2023[at]outlook.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
Please with honesty did you receive my last message i sent to you?
