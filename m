Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841E352C701
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 00:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiERW53 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 18:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiERW5V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 18:57:21 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9AC228
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 15:57:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id q135so6124477ybg.10
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=ovbcf3BPb/ZrA/FpQ+ZjErGDIEZ9sF3fYOxqsE4Z0xdiTlYY9UY36hS3ty6MLllddq
         FdZzNc2PcFHW5cwKZ0FlQqx6F8uTY06Ab/cmT+eL89dkm6I4fHT5v6DDGzwY+fqIjM8b
         RjeYQt93Ckr4p0lPVWY342OwWKznH6xDl4nV36uj7bwrBPcHFh3ePzF5GNEmu/mQBhIV
         GwWDekgJIDWSV60014hyLdzt2NtjUStY8MI6SiwBWMH8LEBnRGkE0W6Db0zUE9IYWmDQ
         Ifd6nbhkESdcIbQrjo3sdEfmdPtb1VAIHCw/LAZv1DOtvQwqLYnhML4dVDmuoYeMmVFn
         q7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=34rERGy0s+cecy3GDTFJjqp3brGf5aJ+wXtJggBAdJkl+9swRaofNgQEsN4MdxdiI4
         Q52HI3t05zvEjbPenNvQ46wHb0GNsRnDfydlcwpSIZoMSsUAC9PCTFtj0YT8AB1yRIFy
         Y3ReAx+VvQRS1rlLlJOXjFJ08Djrsm5gdsA/IPQh2p0rJ+FKNn+RofgHNNJX2L/2oKmA
         y3aXZ6xjxfc1T5VdSS0q5glmB0c2mwxne181P8rmmHk7uPjiaoxPAUOXScGveahqXXHy
         4+KvA4QICSMKRWAjDOTzITHLTW0DxQUavCatyS1Zm6LTeT7AnWHxYUbTVEQfQ0pqQSx4
         yEDw==
X-Gm-Message-State: AOAM532v1ZwnXPkqAyI4Io6KQATvDWQIna3fRjc7yAVTER/5kmrqLD9z
        UgsB6rqx5VEkwMRAEEp+LVlleVtrcVxyDw9uG7yp3PhipQSU9JVf8HL2VkTE
X-Google-Smtp-Source: ABdhPJyyLDAg+sVdsLTxwEXiZ5avjedwK/uWMP/Y3UWcChEjwDE+iXuY4kOycHY8vIqM/rcV0hLTcVdg0IN0RAQYgBc=
X-Received: by 2002:a5b:f87:0:b0:64a:9aa6:e181 with SMTP id
 q7-20020a5b0f87000000b0064a9aa6e181mr1852277ybh.157.1652914614913; Wed, 18
 May 2022 15:56:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7143:0:0:0:0 with HTTP; Wed, 18 May 2022 15:56:53
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <weboutloock4@gmail.com>
Date:   Thu, 19 May 2022 06:56:53 +0800
Message-ID: <CAE2_YrD=5bo8j9+ah-xptEBBV-HEC4=Gb0SRHf996phiopc3WQ@mail.gmail.com>
Subject: engage
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4933]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [weboutloock4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [weboutloock4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Can I engage your services?
