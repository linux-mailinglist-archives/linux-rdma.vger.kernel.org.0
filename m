Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB342CAC1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhJMUSH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 16:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhJMUSG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Oct 2021 16:18:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1366C061570
        for <linux-rdma@vger.kernel.org>; Wed, 13 Oct 2021 13:16:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so5314205ott.2
        for <linux-rdma@vger.kernel.org>; Wed, 13 Oct 2021 13:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YixH6aTUbP6yssRcPsPDk447YdmrQ5wix0UgD3nNBhU=;
        b=n/hT45jMRsp/LBQ97P6lfd/K68aWrNr8csUbb2j3+eFpHlDDElDNd1LZE1V23F7LQl
         SalndDbe6pa0VSGkckkC0XAtZxOVxkD0XNttH2j2FU1wW9j3i7luYw5M/fIs4ZOgGlRu
         4on1rW7HBLkCJvgZb87oJPWAfQZYqeLVkmq7eHnump2Ry253SWD/PUYdUSWY+yOrQ2zZ
         XcaUaxxkJySLMagoICGMbQsizDpww8IzDNiDlByWRXKyBY6smn0+ZJrJepH6l4EKRZEL
         8NISgt5DQEVjBPAvUvLZJMmNQKXFg7OwOMPkFfiSD7dqZPznCX0g5D5Rv2HeUKNSrO3v
         zrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YixH6aTUbP6yssRcPsPDk447YdmrQ5wix0UgD3nNBhU=;
        b=GXk/QMywmwMaBUuKqEIC4zA+QNBW7829DJG6O/DGIpANDZ+HUPpaNcBcyZj6rFon14
         rlI94wql0nsjQ10/WQof8+N5TY1nZMhJT1D8QPX1lhZiMIQy1VTIJBo1yvM5wUpYmalI
         NBNy2SYdzAhxsG3FTBn1YFBfMHixDU0PL4R8YxpQTw0SmPuNPteLdEgtXC8iqhSQOZQE
         cxLQjbu+jWwbrkpIdXk2ze3NNW54TOaay6ojNHo7566uti/7LdeDOCRhKFUAHA7XXv5W
         rbjf+Rufhe2SPH1BQMijLbmg6snRDqs09n3xRbnV7EF09FHIl9lFtW4vUlHLbxqIwsUC
         Jabg==
X-Gm-Message-State: AOAM532AVEu/HgeSbMtx4xEJKk8/k+8XgFlLrSFP/EJZ3hKt0ntjaeU7
        T0mnhuryHKfKGv+uorhnpNNoRa0tIEY=
X-Google-Smtp-Source: ABdhPJxr97A7jzQ3Mk6psWchYVV7AwOLPbDQm3fowmuJBORznO4iX39zW0+nDneHNm/IibVuJfyAUg==
X-Received: by 2002:a9d:609b:: with SMTP id m27mr1154718otj.51.1634156161992;
        Wed, 13 Oct 2021 13:16:01 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:d3c6:f8df:4041:d902? (2603-8081-140c-1a00-d3c6-f8df-4041-d902.res6.spectrum.com. [2603:8081:140c:1a00:d3c6:f8df:4041:d902])
        by smtp.gmail.com with ESMTPSA id w93sm116996otb.78.2021.10.13.13.16.01
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 13:16:01 -0700 (PDT)
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: perftest regression
Message-ID: <9a2cb149-2bca-3908-c0f3-897739c5d617@gmail.com>
Date:   Wed, 13 Oct 2021 15:16:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After the latest pull perftest no longer builds correctly. I get several messages
like the following

src/perftest_parameters.c: In function ‘force_dependecies’:

src/perftest_parameters.c:1082:33: error: ‘MLX5DV_BLOCK_SIZE_520’ undeclared (first use in this function); did you mean ‘AES_XTS_BLOCK_SIZE_520’?

 1082 |    user_param->aes_block_size = MLX5DV_BLOCK_SIZE_520;

      |                                 ^~~~~~~~~~~~~~~~~~~~~

      |                                 AES_XTS_BLOCK_SIZE_520


Bob Pearson
