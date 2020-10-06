Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91866284B02
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJFLgv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFLgv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 07:36:51 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A1C0613D1
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 04:36:50 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q7so5330535ile.8
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=E1vd8qXt0w7+9MzZiMht7tfHSZlqSN7XFIHVejLJJcWDWrigZWeBmYZcdAvkos5pet
         g36THpYDaoWetNd/utf2L5M82gBgMHKnHE+5UYYfG3XbOHyz7BElIkGYQ8lxkvqMY3C4
         bdYt/w2/6O5i9OHU6zmA7pMNiD0i8ouVTJjnl4uyPO6XV59AW1T+ZAt2OWu70XJrugtu
         BWll9p5nKINkixoGr6iPKcT64zt9C/s+9N2LOE20hYW5bGYO+TZpmzgbTWhwIhlX1A8z
         +lplUpwQI4JMO6Bg07Nw3AzkaskHkPPQXcAWWypHutuE9TfbVLlwK+vymdenThETIBbV
         z47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ZJt1R8hKZE3CaFlLABY90fFimvPDYZ2OqFuZKdDoWV3iXBopEk1Kw03NMWDhCQsPae
         zZVkWB8DQUiRFQeyuJupNaMxDXbtFKHsmai0A8LU1+ZpD0zUJtAtdJpv2FSq6CzSJ959
         x2rwESPTZpgkCDfmPPZxt6WUYIuasdhExbosxa5Fi3ejbK3lfPulDNfFa+nmv83hpvOo
         GKEQH64uu+X7hskyu9R7y6zYf1/r4KDglNYICxfi1c+EtV3i9WS3qmi3DXaHQRvDu3w+
         jVaE34I7JEm/buXIYBxoMld1AV+BFCyZ28EoiCtds3PtuguNljmma6bjMgGTLA801xoK
         GFmQ==
X-Gm-Message-State: AOAM532+1qg9YJ51uhCxNt6ouLOvdVZhW8iu6SIdpZSIYgv2TZGO2bbn
        AHaKcIHszGt5OoITM5B7bAp+ZaQR9dzr+KF3/jU=
X-Google-Smtp-Source: ABdhPJwceqdRSPgsm2JQhaIdVfxlfQ0u20eucnFp6wiMkEG+cbOC1F62Ul8EZ37eDEWHtmO8k3exWei8FBqcOOSbZMg=
X-Received: by 2002:a92:cf52:: with SMTP id c18mr3115305ilr.85.1601984210029;
 Tue, 06 Oct 2020 04:36:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:9085:0:0:0:0:0 with HTTP; Tue, 6 Oct 2020 04:36:49 -0700 (PDT)
From:   "D'agostin Zaccaria" <dagostinzaccaria2@gmail.com>
Date:   Tue, 6 Oct 2020 11:36:49 +0000
Message-ID: <CABD98u_5z=BD4S34vUgK5GTnVHL_Q=UKj6ttF8hAANRJ6J1sug@mail.gmail.com>
Subject: =?UTF-8?B?15TXkNedINen15nXkdec16og15DXqiDXlNeU15XXk9ei15Qg15TXp9eV15PXnteqINep?=
        =?UTF-8?B?15zXmT8=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


