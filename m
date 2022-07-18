Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2357853B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiGROVd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGROVc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 10:21:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D871B12D23
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 07:21:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so7424005wmb.5
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=AGaoAZ8ml24T/xt9w0CoIyhC90I0Qb2kP2BNkK9cPslwpZfIlLPNJM/v8noaojI5vh
         SZ3KcJfcfdPhPsQNz4GTQbJ07GLpsI59cIDqpk2aJKjPqx+rGJpVn4bjCGbl9WcR33Af
         VtoVFHOsXw+5+r8l/9eiMtZo8A40OcOzN65+c6SwuEA8oExFAXkpD97ij04KJsOOnUg5
         CW+nJMd4uRVgFKgcB2tDmjdf8ck3E92FH9AHEv6GStmB+MDWCx71ZbLwzawlo0zBlFIn
         OCwIUVdNHwKGFKUVm9Pbt8223CXnlJSQ2S0/FsrKTwaUaWdV51M2kCGWnNnxqTXPWsRd
         7FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=BzmSLrGL2LWF9WFZSy3BPYfpDTMm770QkVksDHuJYk+5/7A3K+tYjEtlZQjAr1dawn
         H6vUZTOWr+2/T0vIPs8odNW8YyLjXMM0sogsSLeg/aP/BD3W3OCUxGoO4QljQ8ecb7qj
         VqMwF6Bhs0tbxroX+z5u/AdcbbdxE9BrThtSTXp2fVdtt3Chd6HQdzm0yLxuibVYv5ub
         7AeDedIF052A5UH4eWGKuwIbbn6w9DkYf6crXeZr6DhtCvaDdXMNN8QcGmn34lgzeWfd
         1mYsk8xxHWdUN1GwStpYuYmL0rnOtygBBhw/zcYEC5MDV3LSbhHjVcMyq8dqMhdonFYf
         NcJg==
X-Gm-Message-State: AJIora+qGgDVmY22sqeALOiTlvavDfltNq1R3+WBUWme3jv/+ezwwgaG
        bndDwpjxVzvpcB6/Wxtv9A7lyywHQJSei9nFqeo=
X-Google-Smtp-Source: AGRyM1uGs36n8cDeEnmHof1GW5dOo5X2NkPaK89mdXtxiiRra1tPLDf4dsIWeeUfodGR3YrE1qCgHST1dEfttWyFjsE=
X-Received: by 2002:a05:600c:4f05:b0:3a3:18ed:6cda with SMTP id
 l5-20020a05600c4f0500b003a318ed6cdamr6707786wmq.34.1658154090462; Mon, 18 Jul
 2022 07:21:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: tatandji59@gmail.com
Received: by 2002:a05:600c:1d14:0:0:0:0 with HTTP; Mon, 18 Jul 2022 07:21:30
 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Mon, 18 Jul 2022 14:21:30 +0000
X-Google-Sender-Auth: ehddc96FDlnQ6AdDIvnUT4hPQfk
Message-ID: <CAK4FRFcNHiVuty_5_72Kfy_NdUs=mMLfTGht_q=SVeWP-rdtwQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

5L2g5aW977yM5L2g5pS25Yiw5oiR5LmL5YmN55qE5Lik5p2h5raI5oGv5LqG5ZCX77yfDQo=
