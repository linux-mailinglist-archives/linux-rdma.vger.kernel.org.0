Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B352656257
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Dec 2022 13:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLZMCB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Dec 2022 07:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLZMCA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Dec 2022 07:02:00 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BB9C7
        for <linux-rdma@vger.kernel.org>; Mon, 26 Dec 2022 04:01:57 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a25so5095365qkl.12
        for <linux-rdma@vger.kernel.org>; Mon, 26 Dec 2022 04:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jkRC4ex5IKPrz4RdILhiW9vt+h6dHQcMXR6mZSg8SGc=;
        b=mMQ1pg/n/zyFCHfFpoqgl85P8ob9D3fj9o2Al/lfHoaewWADNjj+1hQpoM9SZPcxit
         nLOq7jCZhjAg12xFuSuLL8lG6ZtFp13Hdn6WVSHcLnPcVZ4dcry3t2BUaU12ee/dg5jL
         7Xy23xHemgZVN8F5X0cho6qGxNdHR+1ZoBGC9IcMT44CzGuaJDrABtTGosZPZm7yPE8s
         eGQT4Ban5yTzn/T5jSbgtkd9nLi/iQp+w3+V2PfzNC6U1us0CaAJGMbOFG17iKPRTXVD
         l9eZ/GB3sQ4Ks+8qFvveKZ0YM0qS7ZB6V4uvEQqjmLk/+TYumZyB4YqOV/hdpmVhycQ1
         eVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkRC4ex5IKPrz4RdILhiW9vt+h6dHQcMXR6mZSg8SGc=;
        b=5BZbUWe/HOfHk1reBCkAnhxNriAixPX+8OGrJowECqVuNBsxh6hhgcmT3EHrULYEOZ
         lQSthmdDMLWjaxAfyrpFwJ5N1ofwiGSRvrM8w04ImBbuwN48L6rH8uELt5UJTtuakVYC
         7RDFRyKRBWYylFAUrzP0iadi/seI/qWQSF5f4ctUjkMCqz4yL6wovSky+KmbIUWMezf8
         gaTlpRPL31wxIkQ9zLnybCVhMqdk392LlPWiH7fG0BMlWjcErmygci4FbTMLowE4XdE1
         ohVrBCVOwddE0vfLTOUThxH3ENkW+zSeZHiOHB6T6BsJVytqbnMJAa8HjL5OhZ98C23s
         bB3w==
X-Gm-Message-State: AFqh2kpoIzg/b36evxEXolknqtCvHLYQpBEj4zl1hNUK5QO8ebyNAaF4
        FJ6TBbSmFbzvvpOd+FLMXJbYL4LtcCex6HBTFtY=
X-Google-Smtp-Source: AMrXdXvVxOnQmP0fcUn96YqfcmlOYq9eVmvxajBmT7LNECdfYPTcBlKjxdOizPgdBruVDbkiBmmZiphQ6rCM6+InoS8=
X-Received: by 2002:a37:63cc:0:b0:6ee:a33b:a583 with SMTP id
 x195-20020a3763cc000000b006eea33ba583mr544209qkb.352.1672056116531; Mon, 26
 Dec 2022 04:01:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:5a87:0:0:0:0:0 with HTTP; Mon, 26 Dec 2022 04:01:56
 -0800 (PST)
From:   Jacob Egobia Adodo <adodoj41@gmail.com>
Date:   Mon, 26 Dec 2022 10:01:56 -0200
Message-ID: <CA+UpvsVA6wNLNALDsBmnb+OiK5HjMJsQyzAy-yPrCftn2DcV2g@mail.gmail.com>
Subject: Hello ,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello ,
Did you received my e-mail ?
Sincerely,
Egobia
