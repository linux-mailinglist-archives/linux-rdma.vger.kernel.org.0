Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0134C243BB4
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Aug 2020 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMOmW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Aug 2020 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgHMOmW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Aug 2020 10:42:22 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060CEC061757
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 07:42:22 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id k12so4978137otr.1
        for <linux-rdma@vger.kernel.org>; Thu, 13 Aug 2020 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=K2htmOq7NFpdcD9aOKZJ3Y8V8xZ4YM39J7Yabr7PWJg=;
        b=JPslpKxrwAfe4//Moijfs68WYAHKwqsJERU2OJp46xiyckOj34x/NevdY3sX/moWUC
         idgcPx6oaAc7LAAaTtnUtH6BYQZaPXntd0zIwjlm+JdiMCTw2s555yTM2S9BQjcmb8xi
         l2Muzi0ib6KDeDyKiKF4c6HpicvLa13lVRizdo6MdZdZScyWYy9soTJRC9Il234dVBg+
         2X8BWSGmGndYvgDJ1aUHqS0+BMi/yIbj6cu9+dfnj2htcvA3TA+eufo38xKV25tY6+ze
         UQ/bfwhMT275oEP5Dr5bqqRZhYBsGE+YTShdg5gYl/jEOaQ3f5OoOHmn7ESSZDRu3ke+
         BP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=K2htmOq7NFpdcD9aOKZJ3Y8V8xZ4YM39J7Yabr7PWJg=;
        b=Bh3E9uElGeojd6Ij45LemqF5UY0igi1nVmLURep7Ed7JY7rQ6EF7b5ZXcERJruOjLC
         YY/wDaanYd6bOtsA8YKyUhpEzohvuac0nunrIhA72CW7feXqQaY4VKgvwy3ZdbyvYUB/
         /SI+9npdmFPFH+ZQUf4bGaHbNKtR2BlpvJXly3rcDfnPkQuc1heQ7lAZYdXk404kBMCT
         clzy8NbZm8oyuMdtis/c9h2eT9qikPTSbBTIizxpk+jSZCnuHXHtr3jdqBrzDam08apO
         e1zXIvWe2i989UsPoUaLdOEH/DOCtoW0NygzIb4Yd0zkukp5kMV+18DwimKXCWytmuqG
         2d8Q==
X-Gm-Message-State: AOAM531v92ihLptuadCe0UX1kJXFb3hiu7m6XTlv7kyaYYnhis9dstHP
        DykyCyzC0ZDalQGhmyy+LfN2OfPmPHg=
X-Google-Smtp-Source: ABdhPJzXk9bJKrUrYzF9akEG/BxfDJfkd6DpEYbS7G882WDXoDdp/C1sYgViggS64kFhoWcfrMTIfQ==
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr4472508otp.82.1597329739257;
        Thu, 13 Aug 2020 07:42:19 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:d46:5113:64d8:597c? ([2605:6000:8b03:f000:d46:5113:64d8:597c])
        by smtp.gmail.com with ESMTPSA id f3sm1142425otp.15.2020.08.13.07.42.18
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:42:18 -0700 (PDT)
To:     linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: work completion errors
Message-ID: <15a34af9-62af-9367-cd0f-1e5f9da1260b@gmail.com>
Date:   Thu, 13 Aug 2020 09:42:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In IBA Vol 1 Release 1.4 in Table 101 it mentions a Memory Management Operation error type. There doesn't seem to be a good match to that in the current list of WC completions. Is there a plan to add something like this?

I am looking for the correct status to return for a memory invalidate operation that fails. The best options at the moment look like QP operation error or memory fault but neither is really correct.
