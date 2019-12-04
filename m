Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F8E112D80
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2019 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfLDOeS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Dec 2019 09:34:18 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:45832 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfLDOeR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Dec 2019 09:34:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 2C41320299
        for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2019 15:34:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FI_F8pA-0Vri for <linux-rdma@vger.kernel.org>;
        Wed,  4 Dec 2019 15:34:15 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 94C46201AA
        for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2019 15:34:15 +0100 (CET)
Received: from [10.183.7.132] (10.183.7.132) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Dec
 2019 15:34:15 +0100
To:     <linux-rdma@vger.kernel.org>
From:   =?UTF-8?Q?Thorben_R=c3=b6mer?= <thorben.roemer@secunet.com>
Subject: install-step fails for pandoc-prebuilt man-pages in
 infiniband-diags/man
Openpgp: preference=signencrypt
Autocrypt: addr=thorben.roemer@secunet.com; keydata=
 mQENBFr8RUwBCADK68hRaA7dKwwHV9UcR3+sJNCnYtevf34u7SajYwCBx4a7Api+q38b6Hj9
 7eHqhr1G54N4PTis2MUWoG58DaGcUGTgtUgcXBjqZ1EBPtQ6Picf/R7QPNigXLr5oA7Fl3DQ
 Zq3JL7uVRgM23DU1L6rnsWlhfmnwZBAjYY/74KjhhGN4IyxTxnDkyYVhuic91gAm7JdNbCDc
 eylzUkqMgNXbolmOkHJcW/5Wz05OfW5WTOs7ob+uV0G+HtQNTwd+q8EmQ+bvIO7eZ1tHrYCN
 iz1WC8rW0sARugJvUBdE9Z6SAV0XEMbADzvS7fT5UoiHpQYkovD6gRfRCge1d66v8qeXABEB
 AAG0K1Rob3JiZW4gUsO2bWVyIDx0aG9yYmVuLnJvZW1lckBzZWN1bmV0LmNvbT6JAU4EEwEI
 ADgWIQSdqxhsLVCkUA0xpRP4KqBQOtapQgUCWvxFTAIbIwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgAAKCRD4KqBQOtapQrVtB/9MihVdyhNPo/OxZhNzUVTN9yHTSS6u9mxdCklFbufMrHj+
 1ymBIi8hHdA6Dkn/x9IA78JWZnFKtNI1/G2cSwyb3RH3aU/3NW5YC+Ht3RXKCq0GARbG4+E6
 mz7Zdz45iJvJZt+ip1Zjp9g9Mtotkt/EHrGyM6PX7+2ek/3JlOGTIGrnzBSpdIcfQ0QNj89F
 i/V27lR3jptxMyQaqEzX8r8Qpt7OQa0E9e0w/rPBLHn023VbpZiZjFa/xGXbs+TID6oHrSCV
 r1WjdC8FHIntAB7674nCiua7M4W40r3/9hlbpD2Zoxz9qHgRSgMBTwY/5hQduSjGV23dC/hu
 fpvE9MVpuQENBFr8RUwBCADuCg+VosRepPXtAloHmUGay7ClpC7pjccPKmyeQkDcO8HVXP0y
 WPxer0YtoPPUhiMZBLAs8p1RIFQ0NGPP/c2Umee8Fh7O5IQYwjFlF8mDC48XC6I2KJQj6xao
 hzbQrl6C2Ef1+R/o+jExUGfcQYQmxhwB4DocQ6D2PoQdTx7IJxNGSrhx+cD+timWSaG25pzQ
 RrcXYG+YAusKUGhkqMmTnz+yV2u08OyCBezcLrX9qpcFXmU0K6FyBU7YZAuUsYYLyFu4dfAW
 mFfQndIsewvrbOWvcQ+xvCvn+V6/siFLayMw511yYeZfXC2EN9nWDj7UErcjFL2jNU4uNejC
 jmirABEBAAGJATYEGAEIACAWIQSdqxhsLVCkUA0xpRP4KqBQOtapQgUCWvxFTAIbDAAKCRD4
 KqBQOtapQnoVB/9jxi2yHgFBiiV7/vrRZfFlzroy8ewUIxLUtzChL/EJQ8jtIzacNg0GRcrb
 spZ7C+QIR6IJ+8/CriNeHWD9f3U1eEuH1CNgxNo5/LydLb84pskZQVuB6Udd3Nn4KCLiCuOS
 VKZlmN4siVbPoRyliDm2prZN/2zHGluFH0dbfnzv2GABD/EeK0L07queXm6SwrtX9cyBIfR2
 t47ew2YeehdUvt3ZmCnwhjii22C5Dqo6tEwdncYGzYVS4akrawkDp2ApNJOMXXEoEkTBWWQu
 4GL2pWTxEtCP3WQoGKJLow/EH76dasTG2YJqGOkxZdoRhLmnlkSOGqXn1BC4M5VsJCum
Message-ID: <5d754108-7020-6041-1b7d-bbb3fb2f089b@secunet.com>
Date:   Wed, 4 Dec 2019 15:34:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I tested the following on release 0.26.0 and 0.26.1, with the *.tar.gz
provided on github. It is probably relevant for a lot more released
archives and future releases. My build environment is restricted and
does not have access to pandoc or rst2man.

The command 'ninja install' fails in environments without pandoc and/or
rst2man. There is an automatic fallback to use man-pages in
buildlib/pandoc-prebuilt that are added for every release-archive.
However, the install step fails with error such as:

CMake Error at infiniband-diags/man/cmake_install.cmake:40 (file):
file INSTALL cannot find
"rdma-core-26.0/buildlib/pandoc-prebuilt/64a3de4dd91635b29f4f8d11a987670751827c60".
Call Stack (most recent call first):
cmake_install.cmake:166 (include)

To reproduce the issue, you can try building (and installing) one of the
*.tar.gz releases from github, while preventing the checks in
buildlib/Findpandoc.cmake and /Findrst2man.cmake from finding anything
(e.g. by appending random letters to the searched binary name).

While investigating, I came up with the following explanation: The
hashes (generated by buildlib/pandoc-prebuilt.py) differ from machine to
machine, as the contents of the *.rst-files are hashed. Most of these
files are processed via cmake's configure_file from *.in.rst-files and
contain custom-per-build-data such as absolute paths. This means that
hashing *.rst-files will produce differing hashes based on the
build-directory-path (among other data points, possibly). I tested this
by looking at the hashes produced by two of my machines, they were
different for all but 3 files (ibcacheedit.8.rst, ibstatus.8.rst and
check_lft_balance.8.rst). These files (and their includes, as their
content is also hashed!) are the only files that to not contain any
differing data when being transformed from *.in.rst to *.rst via
configure_file, which supports my hypothesis.

From my viewpoint, this tells me that

a) many/all released archives do not contain the correct pandoc-prebuilt
files for infiniband-diags/man
b) there is no automated test that builds and installs releases without
pandoc/rst2man present

With my limited time and expertise in the rdma-core project, I was only
able to come up with a solution that I don't find very practical. I will
append a diff of pandoc-prebuilt.py nonetheless, which replaces
hashing-calls for *.rst to *.in.rst if applicable. With these changes,
the hashes for all files are stable between my two machines. I tested
this by building rdma-core with my pandoc-prebuilt.py on a machine with
pandoc+rst2man, which produces the pandoc-prebuilt files. I can copy
those files to buildlib/pandoc-prebuilt on my other machine in the
restricted build environment (that also has my pandoc-prebuilt.py) and
the 'ninja install' step succeeds.

This is probably not the most suitable solution for this problem and I
do NOT consider it fit for production. But maybe it helps someone
understand and/or fix the root issue. Another fix could be to just hash
the filenames instead of their contents.

Thorben

--- rdma-core-26.0/buildlib/pandoc-prebuilt.py  2019-10-02
12:57:38.000000000 +0200
+++ pandoc-prebuilt.py  2019-12-04 15:21:14.755359320 +0100
@@ -6,10 +6,35 @@
 import hashlib
 import re

+# we shouldn't hash *.rst-files, as they can contain absolute paths
after being
+# transformed from an *.in.rst-file via cmake's configure_file. this
leads to
+# differing pandoc-prebuilt-ids from the build process and other build
+# environments that use pandoc-prebuilt (no rst2man and pandoc).
+# this functions instead corrects the filename from *.rst to *.in.rst
+# if applicable (file exists, correct file ext, ...)
+def infile_if_possible(SRC):
+    # only check *.rst files
+    if not SRC.endswith(".rst"):
+        return SRC;
+
+    # already the desired file
+    if SRC.endswith(".in.rst"):
+        return SRC;
+
+    infile = SRC.rsplit(".", 1)[0] + ".in.rst";
+
+    # use *.in.rst file if possible
+    if os.path.exists(infile):
+        return infile;
+
+    # *fallback*, this still leads to the same error
+    # maybe throw / fail here?
+    return SRC;
+
 def hash_rst_includes(incdir,txt):
     h = ""
     for fn in re.findall(br"^..\s+include::\s+(.*)$", txt,
flags=re.MULTILINE):
-        with open(os.path.join(incdir,fn.decode()),"rb") as F:
+        with
open(infile_if_possible(os.path.join(incdir,fn.decode())),"rb") as F:
             h = h +  hashlib.sha1(F.read()).hexdigest();
     return h.encode();

@@ -17,7 +42,7 @@
     """Return a unique ID for the SRC file. For simplicity and
robustness we just
     content hash it"""
     incdir = os.path.dirname(SRC)
-    with open(SRC,"rb") as F:
+    with open(infile_if_possible(SRC),"rb") as F:
         txt = F.read();
         if SRC.endswith(".rst"):
             txt = txt + hash_rst_includes(incdir,txt);
